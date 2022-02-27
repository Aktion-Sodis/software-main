import databaseOntologies from './constants';

/* eslint-disable-next-line no-unused-vars */
const deriveFilePath = (wantedDerivative, paramsObj) => {
  const derivative = databaseOntologies[wantedDerivative];
  if (Object.keys(paramsObj).length !== derivative.toBeReplaced.length) return -1;
  let res = derivative.path;
  res = res.replace('$', ''); // TODO: only development, not in production!

  Object.keys(paramsObj).forEach((k, i) => {
    res = res.replace(derivative.toBeReplaced[i], paramsObj[k]);
  });
  return res;
};
