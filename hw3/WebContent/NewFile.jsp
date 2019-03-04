<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>test</title>
<style type="text/css">
#father{
	position:relative;
	margin:20px auto;
	width:400px;
	height:100px;
	border:1px solid red;
	}
#father #a{
	position:absolute;
	width:100%;
	height:50px;
	background:blue;
	opacity:0.6;
	z-index:2;
	}
#father #b{
	position:absolute;
	width:100%;
	height:80px;
	background:#F4AF19;
	text-align:right;
	z-index:1;
	}
</style>
</head>
<body>

<div id="father">
	<div id="a">a</div>
    <div id="b">b</div>
</div>
</body>
</html>