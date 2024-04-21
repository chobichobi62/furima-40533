window.addEventListener('turbo:load', () => {
   const priceInput = document.getElementById("item-price");
   priceInput.addEventListener("input", () => {
   const inputValue = priceInput.value;
   const addTaxDom = document.getElementById("add-tax-price");
   const ProfitDom = document.getElementById("profit");
   //入力した金額をもとに販売手数料を計算する処理
   addTaxDom.innerHTML = Math.floor(inputValue * 0.1)
   // 販売利益を計算する処理
   ProfitDom.innerHTML = Math.floor(priceInput.value - Math.floor(priceInput.value * 0.1 ))
   })
});