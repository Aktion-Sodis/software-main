
const queryResult = (sqlPool, query) => {
    return new Promise((resolve, reject)=>{
        sqlPool.query(query,  (error, results)=>{
            if(error){
                return reject(error);
            }
            return resolve(results);
        });
    });
}

export default queryResult