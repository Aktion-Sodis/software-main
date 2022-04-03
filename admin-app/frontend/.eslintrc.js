module.exports = {
  root: true,
  env: {
    node: true,
  },
  extends: ['plugin:vue/essential', '@vue/airbnb'],
  parserOptions: {
    ecmaVersion: 2020,
  },
  rules: {
    'no-console': ['error', { allow: ['warn', 'error'] }],
    'no-debugger': process.env.NODE_ENV === 'production' ? 'error' : 'off',
    'max-classes-per-file': 'off',
    'max-len': 'off',
    'import/prefer-default-export': 0,
    'no-underscore-dangle': 'off',
    'no-param-reassign': 'off',
    'no-console': 'off',
  },
};
