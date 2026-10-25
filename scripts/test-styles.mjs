import assert from 'node:assert/strict';
import { readdir, readFile } from 'node:fs/promises';
import { join } from 'node:path';

// Static checks for the visual system defined in src/styles/global.css.
// Primitives and color literals live only in :root; everything else uses tokens.

const sourceRoot = 'src';
const tokenFile = 'src/styles/global.css';
const allowedWeights = new Set(['400', '500', '600', '700', 'inherit']);
const allowedFamilies = new Set(['var(--font-sans)', 'var(--font-mono)', 'inherit']);
const allowedSizes = /^(var\(--[a-z0-9-]+\)|inherit|1em|0\.875em)$/;
const colorFunction = /#[0-9a-f]{3,8}\b|\b(?:rgba?|hsla?|color-mix)\(/i;
const restrictedPrimitive = /var\(--(?:blue|inverted-)/;
const bannedFonts = /\bGeorgia\b|Times New Roman|\bInter\b/;

const namedColors = new Set(`aliceblue antiquewhite aqua aquamarine azure beige bisque black blanchedalmond blue
blueviolet brown burlywood cadetblue chartreuse chocolate coral cornflowerblue cornsilk crimson cyan darkblue
darkcyan darkgoldenrod darkgray darkgreen darkgrey darkkhaki darkmagenta darkolivegreen darkorange darkorchid
darkred darksalmon darkseagreen darkslateblue darkslategray darkslategrey darkturquoise darkviolet deeppink
deepskyblue dimgray dimgrey dodgerblue firebrick floralwhite forestgreen fuchsia gainsboro ghostwhite gold
goldenrod gray green greenyellow grey honeydew hotpink indianred indigo ivory khaki lavender lavenderblush
lawngreen lemonchiffon lightblue lightcoral lightcyan lightgoldenrodyellow lightgray lightgreen lightgrey
lightpink lightsalmon lightseagreen lightskyblue lightslategray lightslategrey lightsteelblue lightyellow lime
limegreen linen magenta maroon mediumaquamarine mediumblue mediumorchid mediumpurple mediumseagreen
mediumslateblue mediumspringgreen mediumturquoise mediumvioletred midnightblue mintcream mistyrose moccasin
navajowhite navy oldlace olive olivedrab orange orangered orchid palegoldenrod palegreen paleturquoise
palevioletred papayawhip peachpuff peru pink plum powderblue purple rebeccapurple red rosybrown royalblue
saddlebrown salmon sandybrown seagreen seashell sienna silver skyblue slateblue slategray slategrey snow
springgreen steelblue tan teal thistle tomato turquoise violet wheat white whitesmoke yellow yellowgreen`.split(/\s+/));

// Replace matched text with spaces so offsets, and therefore line numbers, are preserved.
const blank = (text) => text.replace(/[^\n]/g, ' ');
const lineAt = (text, index) => text.slice(0, index).split('\n').length;

export function checkCss(css, file, lineOffset = 0) {
  const violations = [];
  const report = (index, message) => violations.push(`${file}:${lineOffset + lineAt(css, index)} ${message}`);
  const withoutComments = css.replace(/\/\*[\s\S]*?\*\//g, blank);

  const fontMatch = withoutComments.match(bannedFonts);
  if (fontMatch) report(fontMatch.index, `must not reference ${fontMatch[0]}`);

  const scoped = withoutComments.replace(/:root\s*\{[^{}]*\}/g, blank);
  for (const match of scoped.matchAll(/([-a-z]+)\s*:\s*([^;{}]+)(?=[;}])/g)) {
    const [, property, rawValue] = match;
    const value = rawValue.trim();
    const at = (message) => report(match.index, `${property}: ${value} — ${message}`);

    if (property === 'font') at('use font-family, font-size, and font-weight instead of the font shorthand');
    if (property === 'font-family' && !allowedFamilies.has(value)) at('font-family must be var(--font-sans) or var(--font-mono)');
    if (property === 'font-weight' && !allowedWeights.has(value)) at('font-weight must be 400, 500, 600, or 700');
    if (property === 'font-size' && !allowedSizes.test(value)) at('font-size must use a type-scale token');
    if (property === 'box-shadow' && value !== 'none') at('box-shadow is not part of the visual system');
    if (restrictedPrimitive.test(value)) at('reference a role token, not a blue or inverted primitive');

    const unquoted = value.replace(/(["'])(?:(?!\1).)*\1/g, '').replace(/var\(--[-a-z0-9]+\)/gi, '');
    if (colorFunction.test(unquoted)) at('color literals belong in the :root token block');
    const keyword = unquoted.match(/-?[a-z][a-z-]*/gi)?.find((word) => namedColors.has(word.toLowerCase()));
    if (keyword) at(`named color "${keyword}" belongs in the :root token block`);
  }
  return violations;
}

export function checkAstro(source, file) {
  const violations = [];
  let markup = source;
  for (const match of source.matchAll(/<style[^>]*>([\s\S]*?)<\/style>/g)) {
    const contentStart = match.index + match[0].indexOf('>') + 1;
    violations.push(...checkCss(match[1], file, lineAt(source, contentStart) - 1));
    markup = markup.slice(0, match.index) + blank(match[0]) + markup.slice(match.index + match[0].length);
  }
  for (const match of markup.matchAll(/\sstyle\s*=/g)) {
    violations.push(`${file}:${lineAt(markup, match.index)} inline style attributes are not allowed; use a class`);
  }
  return violations;
}

function relativeLuminance(hex) {
  const value = hex.length === 4 ? hex.slice(1).split('').map((c) => c + c).join('') : hex.slice(1);
  const [r, g, b] = [0, 2, 4].map((offset) => {
    const channel = parseInt(value.slice(offset, offset + 2), 16) / 255;
    return channel <= 0.03928 ? channel / 12.92 : ((channel + 0.055) / 1.055) ** 2.4;
  });
  return 0.2126 * r + 0.7152 * g + 0.0722 * b;
}

export function contrast(a, b) {
  const [light, dark] = [relativeLuminance(a), relativeLuminance(b)].sort((x, y) => y - x);
  return (light + 0.05) / (dark + 0.05);
}

function resolveTokens(css) {
  const root = css.match(/:root\s*\{([^{}]*)\}/)?.[1] ?? '';
  const raw = Object.fromEntries([...root.matchAll(/(--[-a-z0-9]+)\s*:\s*([^;]+);/g)].map(([, name, value]) => [name, value.trim()]));
  const resolve = (name, depth = 0) => {
    const value = raw[name];
    assert.ok(value, `${tokenFile} must define ${name}`);
    const reference = value.match(/^var\((--[-a-z0-9]+)\)$/);
    if (reference && depth < 5) return resolve(reference[1], depth + 1);
    assert.match(value, /^#[0-9a-f]{3,6}$/i, `${name} must resolve to a hex color`);
    return value;
  };
  return resolve;
}

function testContrast(css) {
  const resolve = resolveTokens(css);
  const textPairs = [
    ['--text', '--background'],
    ['--text-strong', '--background'],
    ['--text-muted', '--background'],
    ['--text-muted', '--background-subtle'],
    ['--link', '--background'],
    ['--link', '--selected-bg'],
    ['--selected-text', '--selected-bg'],
    ['--badge-text', '--badge-bg'],
    ['--badge-neutral-text', '--badge-neutral-bg'],
    ['--code-text', '--code-bg'],
    ['--button-text', '--button-bg'],
    ['--button-text', '--button-bg-hover'],
    ['--button-text', '--button-bg-active'],
    ['--skip-link-text', '--skip-link-bg'],
  ];
  const indicatorPairs = [
    ['--focus-ring', '--background'],
    ['--selected-indicator', '--background'],
    ['--selected-indicator', '--selected-bg'],
    ['--control-border', '--background'],
  ];
  for (const [pairs, minimum] of [[textPairs, 4.5], [indicatorPairs, 3]]) {
    for (const [foreground, background] of pairs) {
      const ratio = contrast(resolve(foreground), resolve(background));
      assert.ok(ratio >= minimum, `${foreground} on ${background} is ${ratio.toFixed(2)}:1; needs ${minimum}:1`);
    }
  }
}

function testCheckerCatchesViolations() {
  const flagged = [
    '.a { font-family: Georgia, serif; }',
    '.a { font-family: "Inter", sans-serif; }',
    '.a { font-weight: 750; }',
    '.a { font-size: 1.2rem; }',
    '.a { font: 500 1rem serif; }',
    '.a { color: #fff; }',
    '.a { background: rgb(25 61 51 / .05); }',
    '.a { border-color: color-mix(in srgb, var(--text) 50%, transparent); }',
    '.a { color: white; }',
    '.a { box-shadow: 0 1px 2px var(--border); }',
    '.a { color: var(--blue-hover); }',
    '@media (max-width: 720px) { .a { color: var(--inverted-text); } }',
  ];
  for (const css of flagged) {
    assert.ok(checkCss(css, 'fixture.css').length > 0, `the style check must flag: ${css}`);
  }

  const passing = [
    ':root { --x: #ffffff; --y: var(--blue); font-family: var(--font-sans); }',
    '.a:hover { color: var(--link-hover); border-left: 2px solid transparent; }',
    '.a { font-family: inherit; }',
    '.a { font-size: var(--title-page); font-weight: 600; box-shadow: none; }',
    '.a::before { content: "red white"; white-space: nowrap; }',
    '.a :not(pre) > code { font-size: 0.875em; }',
  ];
  for (const css of passing) {
    assert.deepEqual(checkCss(css, 'fixture.css'), [], `the style check must accept: ${css}`);
  }

  assert.equal(checkAstro('<div style="margin-top: 4px"></div>', 'fixture.astro').length, 1, 'inline style attributes must be flagged');
  assert.deepEqual(checkAstro('<div class="a"></div>\n<style>\n  .a { color: var(--text); }\n</style>', 'fixture.astro'), []);
  assert.match(checkAstro('<p></p>\n<style>\n  .a { color: red; }\n</style>', 'fixture.astro')[0], /fixture\.astro:3 /, 'violations must report the source line');
}

async function testSources() {
  const files = (await readdir(sourceRoot, { recursive: true }))
    .filter((file) => file.endsWith('.css') || file.endsWith('.astro'))
    .map((file) => join(sourceRoot, file))
    .sort();
  assert.ok(files.includes(tokenFile), `${tokenFile} must be scanned`);

  const violations = [];
  for (const file of files) {
    const source = await readFile(file, 'utf8');
    violations.push(...(file.endsWith('.css') ? checkCss(source, file) : checkAstro(source, file)));
  }
  assert.deepEqual(violations, [], `style rules violated:\n${violations.join('\n')}`);

  testContrast(await readFile(tokenFile, 'utf8'));
  return files.length;
}

testCheckerCatchesViolations();
const scanned = await testSources();
console.log(`Style checks passed (${scanned} files).`);
