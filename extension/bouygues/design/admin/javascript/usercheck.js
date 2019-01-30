function initButton() {
  $('.checkConfirm').click(checkConfirm);
  $('.checkDo').click(function(oEvent){window.location.href = $(oEvent.currentTarget).attr('data-url');});  
}

function checkConfirm (oEvent) {
  if (confirm('Cette opération supprimera définitivement les données ciblées sans possibilité de récupération.\nÊtes-vous sûr de vouloir faire ça ?')) {
    window.location.href = $(oEvent.currentTarget).attr('data-url');
  }
}

$(document).ready(function() {
  initButton();
});