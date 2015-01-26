<?php
$scheme = 4;
$ymca_name = 'My YMCA';
?>
<html>
	<head>
		<link href='http://fonts.googleapis.com/css?family=Lato:100' rel='stylesheet' type='text/css'>

		<style>
			body {
				margin: 0;
				padding: 0;
				width: 100%;
				height: 100%;
				color: #B0BEC5;
				display: table;
				font-weight: 100;
				font-family: 'Lato';
			}

			.container {
				text-align: center;
				display: table-cell;
				vertical-align: middle;
			}

			.content {
				text-align: center;
				display: inline-block;
			}

			.logo, .logo.scheme-1 {
				width:160px;
				height:130px;
				overflow:hidden;
				background-image: url("ymca_logo.png");
				background-position: 0 0;
				text-indent: 100%;
				white-space: nowrap;
			}

			.logo.scheme-2{
				background-position: 0 -160px;
			}

			.logo.scheme-3{
				background-position: 0 -320px;
			}

			.logo.scheme-4{
				background-position: 0 -480px;
			}

			.logo.scheme-5{
				background-position: 0 -640px;
			}

			.logo.scheme-6{
				background-position: 0 -800px;
			}

			.title {
				font-size: 24px;
				margin-top:10px
			}

		</style>
	</head>
	<body>
		<div class="container">
			<div class="content">
				<div class="logo scheme-<?php print $scheme; ?>"><?php print $ymca_name; ?></div>
				<div class="title"><?php print $ymca_name; ?></div>
			</div>
		</div>
	</body>
</html>
