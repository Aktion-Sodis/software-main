import * as mutations from "../graphql/mutations.js";
import * as fs from "fs";
import * as path from "path";
import {
  InterventionType,
  SurveyType,
  QuestionType,
  Type,
} from "../models/index.js";
import { API, graphqlOperation, Storage } from "aws-amplify";
import mlString from "../utils/stringFormatter.js";
import * as queries from "../graphql/queries.js";

export default async function uploadTestFiles() {
    try {
        const __dirname = path.resolve();
        const allEntityQuery = await API.graphql({
        query: queries.listEntities
    });
    const allEntities = allEntityQuery.data.listEntities.items.filter((obj) => !obj._deleted);
    for(const entity of allEntities) {
        try {
           const key = "entityFiles/" + entity.id + "/pic.png";
        const filePath = path.join(__dirname, 'src','files', 'test_pic.png');
        const file = fs.readFileSync(filePath);
        console.log('got file -> now upload');
        await Storage.put(key, file); 
        }catch(e){
            console.log("error in file upload");
            console.log(e);
        }
        
    }
    const allContentQuery = await API.graphql({query: queries.listContents});
    const allContents = allContentQuery.data.listContents.items.filter((obj) => !obj._deleted);
    for(const content of allContents) {
        try {
            const key = "documentFiles/" + content.id + "/pdf.pdf";
        const filePath = path.join(__dirname, 'src', 'files', 'whitepaper.pdf');
        const file = fs.readFileSync(filePath);
        console.log('got file -> now upload');
        await Storage.put(key, file);
        }catch(e) {
            console.log("error in file upload");
            console.log(e);
        }
        
    }
    }catch(e) {
        console.log("error in file upload");
        console.log(e);
    }
    
    
}