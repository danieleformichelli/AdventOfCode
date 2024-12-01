import globals from "globals";
import simpleImportSort from "eslint-plugin-simple-import-sort";
import tseslint from "typescript-eslint";

const offRules = {
  "@typescript-eslint/explicit-member-accessibility": "off", // forces public/private/protected on methods
  "@typescript-eslint/member-ordering": "off", // forces public methods before private ones
  "@typescript-eslint/naming-convention": "off", // strict camelCase, ALL CAPS, etc. for names
  "@typescript-eslint/no-misused-promises": "off", // error when returning promises unexpectedly... interesting
  "@typescript-eslint/no-non-null-assertion": "off", // no ! operator
  "@typescript-eslint/no-parameter-properties": "off", // copyright doc string at top of files are marked as errors
  "@typescript-eslint/no-unsafe-assignment": "off", // more any protection, can't assign any to a variable
  "@typescript-eslint/no-unsafe-call": "off", // protects against calling indexing possible any values
  "@typescript-eslint/no-unsafe-member-access": "off", // requires member (also for arrays) to be present before trying to access
  "@typescript-eslint/no-unsafe-return": "off", // prevents returning any or any[]
  "@typescript-eslint/no-use-before-define": "off", // helps with ordering, not sure what type of error this saves us from
  "@typescript-eslint/prefer-regexp-exec": "off", // prefer exec method for regex, only 12 errors
  "@typescript-eslint/require-await": "off", // could help us identify functions that are currently async that don't need to be, need to change some signatures
  "@typescript-eslint/restrict-template-expressions": "off", // restricts from using objects in strings with ${}
  "@typescript-eslint/unbound-method": "off", // something to do with this for function calls
  camelcase: "off",
  "class-methods-use-this": "off",
  complexity: "off",
  "consistent-return": "off",
  "default-case": "off",
  "dot-notation": "off", // @typescript-eslint/dot-notation
  "func-names": "off",
  "guard-for-in": "off",
  "jsx-a11y/alt-text": "off",
  "jsx-a11y/anchor-is-valid": "off",
  "jsx-a11y/click-events-have-key-events": "off",
  "jsx-a11y/no-noninteractive-element-interactions": "off",
  "jsx-a11y/no-static-element-interactions": "off",
  "max-classes-per-file": "off",
  "new-cap": "off",
  "no-alert": "off",
  "no-async-promise-executor": "off",
  "no-await-in-loop": "off",
  "no-case-declarations": "off",
  "no-continue": "off",
  "no-constant-condition": "off",
  "no-template-curly-in-string": "off",
  "no-duplicate-case": "off",
  "no-else-return": "off",
  "no-ex-assign": "off",
  "no-extend-native": "off",
  "no-extra-boolean-cast": "off",
  "no-fallthrough": "off", // Enforced by TS
  "no-inner-declarations": "off",
  "no-invalid-this": "off",
  "no-loop-func": "off",
  "no-multi-assign": "off",
  "no-multi-str": "off",
  "no-nested-ternary": "off",
  "no-new": "off",
  "no-param-reassign": "off",
  "no-plusplus": "off",
  "no-prototype-builtins": "off",
  "no-regex-spaces": "off",
  "no-restricted-globals": "off",
  "no-restricted-properties": "off",
  "no-restricted-syntax": "off",
  "no-return-assign": "off",
  "no-return-await": "off",
  "no-self-assign": "off",
  "no-self-compare": "off",
  "no-sequences": "off",
  "no-shadow": "off", // @typescript-eslint/no-shadow
  "no-throw-literal": "off", // @typescript-eslint/no-throw-literal
  "no-underscore-dangle": "off",
  "no-unneeded-ternary": "off",
  "no-unused-expressions": "off", // @typescript-eslint/no-unused-expressions
  "no-unused-vars": "off", // @typescript-eslint/no-unused-vars
  "no-use-before-define": "off",
  "no-useless-computed-key": "off",
  "no-useless-constructor": "off", // @typescript-eslint/no-useless-constructor
  "no-useless-escape": "off",
  "no-useless-return": "off",
  "operator-assignment": "off",
  "prefer-destructuring": "off",
  "prefer-object-spread": "off",
  "prefer-promise-reject-errors": "off",
  "prefer-rest-params": "off",
  "prefer-spread": "off",
  "prefer-template": "off",
  radix: "off",
  "simple-import-sort/exports": "off",
  "sort-keys": "off",
  "valid-typeof": "off",
};

const oneLineErrorRules = {
  "@typescript-eslint/await-thenable": "error",
  "@typescript-eslint/ban-ts-comment": "error",
  "@typescript-eslint/consistent-type-assertions": "error",
  "@typescript-eslint/consistent-type-definitions": "error",
  "@typescript-eslint/dot-notation": "error",
  "@typescript-eslint/explicit-module-boundary-types": "error",
  "@typescript-eslint/no-empty-function": "error",
  "@typescript-eslint/no-explicit-any": "error",
  "@typescript-eslint/no-floating-promises": "error",
  "@typescript-eslint/no-for-in-array": "error",
  "@typescript-eslint/no-misused-new": "error",
  "@typescript-eslint/no-namespace": "error",
  "@typescript-eslint/no-shadow": "error",
  "@typescript-eslint/no-unnecessary-type-assertion": "error",
  "@typescript-eslint/no-unsafe-function-type": "error",
  "@typescript-eslint/no-unused-expressions": "error",
  "@typescript-eslint/no-useless-constructor": "error",
  "@typescript-eslint/no-var-requires": "error",
  "@typescript-eslint/no-wrapper-object-types": "error",
  "@typescript-eslint/only-throw-error": "error",
  "@typescript-eslint/prefer-for-of": "error",
  "@typescript-eslint/prefer-function-type": "error",
  "@typescript-eslint/prefer-namespace-keyword": "error",
  "@typescript-eslint/restrict-plus-operands": "error",
  "@typescript-eslint/switch-exhaustiveness-check": "error",
  "@typescript-eslint/strict-boolean-expressions": "error",
  "@typescript-eslint/unified-signatures": "error",
  "arrow-body-style": "error",
  "constructor-super": "error",
  curly: "error",
  "id-match": "error",
  "no-bitwise": "error",
  "no-caller": "error",
  "no-cond-assign": "error",
  "no-console": "error",
  "no-debugger": "error",
  "no-duplicate-imports": "error",
  "no-empty": "error",
  "no-eval": "error",
  "no-lonely-if": "error",
  "no-new-wrappers": "error",
  "no-self-compare": "error",
  "no-unused-labels": "error",
  "no-unsafe-finally": "error",
  "no-unsafe-negation": "error",
  "no-unsafe-optional-chaining": "error",
  "no-useless-assignment": "error",
  "no-var": "error",
  "object-shorthand": "error",
  "prefer-const": "error",
  "simple-import-sort/imports": "error",
  "use-isnan": "error",
};

const rules = {
  "@typescript-eslint/return-await": ["error", "in-try-catch"],
  "@typescript-eslint/explicit-function-return-type": [
    "error",
    { allowTypedFunctionExpressions: true },
  ],
  "@typescript-eslint/triple-slash-reference": [
    "error",
    {
      lib: "always",
      path: "always",
      types: "prefer-import",
    },
  ],
  "@typescript-eslint/no-inferrable-types": [
    "error",
    { ignoreParameters: true },
  ],
  "@typescript-eslint/no-unused-vars": ["error", { argsIgnorePattern: "_*" }],
  eqeqeq: ["error", "always"],
  "no-restricted-imports": [
    "error",
    {
      patterns: ["*src*", "*dist*", "*node_modules*", "en-thrift-internal"],
    },
  ],
  "one-var": ["error", "never"],
  ...offRules,
  ...oneLineErrorRules,
};

export default tseslint.config(
  {
    files: ["workspaces/**/*.ts", "scripts/*.ts", "*.ts"],
    plugins: {
      "@typescript-eslint": tseslint.plugin,
      "simple-import-sort": simpleImportSort,
    },
    languageOptions: {
      ecmaVersion: 6,
      sourceType: "module",
      parser: tseslint.parser,
      parserOptions: {
        projectService: true,
      },
      globals: {
        ...globals.browser,
        ...globals.es2015,
        ...globals.jest,
        ...globals.node,
      },
    },
    rules,
  },
  {
    ignores: [
      "**/*.d.ts",
      "**/*.js",
      "**/android/**",
      "**/assets/**",
      "**/autogen/**",
      "**/build/**",
      "**/dist/**",
      "**/ios/**",
      "**/node_modules/**",
      "**/scriptdist/**",
    ],
  },
);
