import { databaseOntologies } from './constants';

/* eslint-disable-next-line no-unused-vars */
export const deriveFilePath = (wantedDerivative, paramsObj) => {
  const derivative = databaseOntologies[wantedDerivative];
  if (Object.keys(paramsObj).length !== derivative.toBeReplaced.length) return -1;
  let res = derivative.path;
  res = res.replace('$', ''); // TODO: only development, not in production!

  Object.keys(paramsObj).forEach((k, i) => {
    res = res.replace(derivative.toBeReplaced[i], paramsObj[k]);
  });
  return res;
};

export const compareI18nStrings = (a, b) => {
  if (a.languageKeys.length !== b.languageKeys.length) return false;
  for (let i = 0; i < a.languageKeys.length; i += 1) {
    if (a.languageKeys[i] !== b.languageKeys[i]) return false;
    if (a.languageTexts[i] !== b.languageTexts[i]) return false;
  }
  return true;
};
