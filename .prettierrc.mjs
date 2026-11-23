export default {
  plugins: ['prettier-plugin-ember-template-tag'],
  overrides: [
    {
      files: '*.{js,gjs,ts,gts,mjs,mts,cjs,cts}',
      options: {
        singleQuote: true,
        templateSingleQuote: false,
      },
    },
    {
      // Preserve quotes in generated CSS module declaration files so that
      // class names that require quoting (e.g. kebab-case) are never broken.
      files: '*.css.d.ts',
      options: {
        quoteProps: 'preserve',
      },
    },
  ],
};
