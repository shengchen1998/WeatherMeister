<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
        <title>mydiv</title>
        <script type="text/javascript" src="jquery/jquery.js"></script>
        <script language="javascript">
            function show(index1, index2){ 
                document.getElementById(index1).style.display = "";
                document.getElementById(index2).style.display = "none";
            }
             
             
        </script>   
    </head>
    <body>
            <table>
                <tr>
                    <td height="33" class="c">捐助类型：</td>
                    <td class="c">
                        <input type='radio' name='ydzztype' class='np' value='现金' onclick="show(2, 3);"  checked="checked">现金
                        <input type='radio' name='ydzztype' class='np' value='实物' onclick="show(3, 2);">实物 
                    </td>
                </tr>
                <tr id="1" >
                    <td height="33" class="c">捐助款项：</td>
                    <td class="c"><input name="textfield7" type="text" id="textfield7" size="20" />&nbsp;&nbsp;元</td>
                </tr>
                <tr id="2" >
                    <td height="33" class="c">汇款银行：</td>
                    <td><input type='text' name='ydbank' id='ydbank' size="40" /></td>
                </tr>
                <tr id="3" style="display:none;" >
                    <td height="33" class="c">捐助实物：</td>
                    <td><input type='text' name='ydjzshiwu' id='ydjzshiwu' size="40" /></td>
                </tr>
            </table>
    </body>
</html>