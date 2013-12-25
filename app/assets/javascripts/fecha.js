
function SelectOptionRange(init,finish) {
 var options = "";
 
for(var i = init; i<finish; i++ ) {
    document.write("<option value="+ i +">"+i+"</option>");
 }

return options;


}