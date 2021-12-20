export enum DocTagsEnum {
  "Bauanleitung",
  "Tutorial",
  "Kochstelle",
}

export interface Geoloc {
  longitude: number;
  latitude: number;
}

export enum SurveyTypesEnum {
  "Initial",
}

export enum QuestionTypesEnum {
  "MultipleChoice",
}

export enum ShapesEnum {
  "Rectangle",
  "Ellipse",
  "Triangle",
}

export type UUID = string | null;

export type shortText = string;
export type longText = string;

export interface Marking {
  x1: number;
  y1: number;
  x2: number;
  y2: number;
  rotation: number;
  shape: ShapesEnum;
}
