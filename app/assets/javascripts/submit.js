 function ButtonRegister()
{

var terms=document.getElementById("Terms & Conditions").checked;

if(terms){

	var man=document.getElementById("man").checked;
	var woman=document.getElementById("woman").checked;

	if(man && !woman || !man&&woman){

		var email= document.getElementById("email").value;
		var confirmationemail= document.getElementById("confirmation email").value;
		
		
		if(email==confirmationemail && email!=""){
		
		
			var password=document.getElementById("password").value;
			var confirmationpassword=document.getElementById("confirmation password").value;

				if(password==confirmationpassword && password!=""){
			
						var list_day= document.getElementById("day");
						var day = list_day.options[list_day.selectedIndex].text;

						var list_month= document.getElementById("month");
						var month = list_month.options[list_month.selectedIndex].text;

						var list_year= document.getElementById("year");
						var year = list_year.options[list_year.selectedIndex].text;
						
						var bisiesto = (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) ? 1 : 0;

                          if (bisiesto) var FebruaryDay=29;
                            else var FebruaryDay=28;

                         if(((month==11 || month==4 || month==6 || month==9) && day>30)||(month==2 && day>FebruaryDay) || year=="Año" || day=="Día" || month=="Mes")
                            alert("Introduce una fecha de nacimiento correcta");
                         else{
                         		var name= document.getElementById("name").value;
								var surname= document.getElementById("surname").value;
					      
					         	if(name!="" && surname!=""){
					
										//parent.location.href='mailto:'+"javieralejos89@gmail.com"+'?subject='+"prueba"+'';
										//document.write('<script type="text/javascript" src="2.js"></script>');

                                  		alert("registro correcto");
										//alert("Se ha enviado un correo electrónico de verificación de la cuenta creada") ;
								
								}else alert("Introduce nombre y apellidos");
							} 
							
			}else alert("Introduce la misma contraseña en los dos campos");
		} else alert("Introduce el mismo email en los dos campos");
		
	} else alert("Tienes que selecionar hombre o mujer");



} else alert("No has aceptado los terminos y condiciones");







}





 