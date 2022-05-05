import { databaseOntologies } from './constants';

import i18n from '../i18n';

export const formValidators = {
  required: (value) => !!value || i18n.t('general.form.required'),
  minPasswordLength: (value) => {
    const minChar = process.env.VUE_APP_MIN_PASSWORD_LENGTH;
    const minCharI18n = i18n.t('general.form.minCharNotMet', {
      minChar,
    });
    return value.length >= process.env.VUE_APP_MIN_PASSWORD_LENGTH || minCharI18n;
  },
  notEmpty: (value) => !value || value.replace(/ /g, '') !== '' || i18n.t('general.form.required'),
};

/* eslint-disable-next-line no-unused-vars */
export const deriveFilePath = (wantedDerivative, paramsObj) => {
  const derivative = databaseOntologies[wantedDerivative];
  if (Object.keys(paramsObj).length !== derivative.toBeReplaced.length) return -1;
  let res = derivative.path;

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

export const waitForMilliseconds = (milliseconds) => new Promise((resolve) => setTimeout(resolve, milliseconds));
