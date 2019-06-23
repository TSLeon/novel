$(document).ready(function () {
   $('#register-label').click(function () {
       if($('#check-self').is(':checked')) {
           $('#register').removeAttr("disabled");
       }
       else {
           $('#register').attr("disabled","disabled");
       }
   });
});