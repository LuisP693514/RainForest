export const formatWithCommas = (number) => number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

export const filterProducts = (arr, catId) => {
    Object.freeze(arr)
    const newArr = []

    for (let i = 0; i < arr.length; i++) {
        const element = arr[i];
        if (element.categoryId == catId) newArr.push(element);
    }
    return newArr;
}
