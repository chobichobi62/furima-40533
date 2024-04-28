const pay = () => {
  const publicKey = gon.public_key
  const payjp = Payjp(publicKey) // PAY.JPテスト公開鍵
  const form = document.getElementById('charge-form')
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

    form.addEventListener("submit", (e) => {
payjp.createToken(numberElement).then(function (response) {
  if (response.error) {
  } else {
    const token = response.id;
    const renderDom = document.getElementById("charge-form");
    const tokenObj = `<input value=${token} name='token' type="hidden">`;
    renderDom.insertAdjacentHTML("beforeend", tokenObj);
  }
  //クレジット情報の削除
  numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      //フォームの情報をサーバーサイドに送信
      document.getElementById("charge-form").submit();
});
    //フォーム送信処理をキャンセル
    e.preventDefault();
});
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);