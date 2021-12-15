const recursiveMarker = (root, markArray, returnArray = []) => {
  markArray = markArray.map((e) =>
    e.entityId === root.entityId ? { ...e, marked: true } : e
  );
  const notMarkedData = markArray.filter((e) => !e.marked);
  const directChildren = notMarkedData.filter(
    (e) => e.upperEntityId === root.entityId
  );
  directChildren.forEach((e) => {
    returnArray.push(e);
    recursiveMarker(e, notMarkedData, returnArray);
  });
  return returnArray;
};

export default recursiveMarker;
