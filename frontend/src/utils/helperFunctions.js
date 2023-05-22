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

export const generateNumber = () => {
    const part1 = Math.floor(Math.random() * 1000).toString().padStart(3, '0');
    const part2 = Math.floor(Math.random() * 10000000).toString().padStart(7, '0');
    const part3 = Math.floor(Math.random() * 10000000).toString().padStart(7, '0');

    const randomNumber = `${part1}-${part2}-${part3}`;
    return randomNumber;
}
