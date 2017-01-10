@charset "utf-8";
/* CSS Document */


/* for clearing floats */
.clear:before, .clear:after {
	content:"";
	display:table;
}
.clear:after {
	clear:both;
}
.clear {
	zoom:1; /* For IE 6/7 (trigger hasLayout) */
}
/* =================== Start of wrapper *================*/
body {
	font-family:Georgia, "Times New Roman", Times, serif
}
#wrapper {
	background-color:#F4F4F4;
	max-width: 62.5em;
	margin:0 auto;
}
/* =================== Start of header *================*/
header {
	border-bottom:3px solid #00738F;
}
header .columns:first-child {
	padding:0;
}
/* for logo */
header .logo {
	padding-top:20px;
	padding-left:10px;
	box-sizing:border-box;
	-moz-box-sizing: border-box;
	-webkit-box-sizing: border-box;
}
header .logo a img {
	border-radius:10px;
}
header .heading {
	padding:1%;
}
/* start of navigation */
header nav {
	text-align:center;
}
header nav ul {
	list-style:none;
	margin-bottom:0;
}
header nav ul li {
	background: #CCC;
	margin-bottom:10px;
}
header nav ul li a {
	padding:0 5px;
	display:inline-block;
	text-emphasis:accent;
	font-size: 0.825em;
}
header nav ul li:first-child a {
	border-left:0;
}
header nav ul li a:link {
	color:black;
}
header nav ul li a:hover, header nav ul li a:focus {
	color:#2BA6CB;
}
/* end of navigation */

/* start of mainSearch */
header .mainSearch {
	text-align:center;
}
header .mainSearch form {
	background: #bfd255;
	background: -moz-linear-gradient(top, #bfd255 0%, #8eb92a 50%, #72aa00 51%, #9ecb2d 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #bfd255), color-stop(50%, #8eb92a), color-stop(51%, #72aa00), color-stop(100%, #9ecb2d));
	background: -webkit-linear-gradient(top, #bfd255 0%, #8eb92a 50%, #72aa00 51%, #9ecb2d 100%);
	background: -o-linear-gradient(top, #bfd255 0%, #8eb92a 50%, #72aa00 51%, #9ecb2d 100%);
	background: -ms-linear-gradient(top, #bfd255 0%, #8eb92a 50%, #72aa00 51%, #9ecb2d 100%);
	padding:5px 8px;
	margin:0;
}
header .mainSearch input[type = "search"] {
	width:75%;
	display:inline;
	margin-bottom:0;
	height:24px;
}
header .mainSearch form .searchButton {
	width:24px;
	height:24px;
	border:0;
	background:url(../img/search.png) left center no-repeat;
	background-color:transparent;
}
header .logout {
	margin:5px;
	font-size:0.825em;
	
}
header .logout a {
	color:#333;
	
}
header .logout a span{
	display:inline-block;
	width:16px;
	height:16px;
	background:url(../img/logout.png) left bottom no-repeat ;
	padding-right:17px;
}
/* end of mainSearch */
/* =================== end of header *================*/

/* =================== start of main content *================*/


.mainContent {
	padding-bottom:10px;
	max-width: 71.5em;
	margin:0 auto;
}
.mainContent .large-12 {
	display:table;
}
#wrapper .mainContent .large-12 .large-8, #wrapper .mainContent .large-12 .large-4{
	display:table-cell;
}
.mainContent .forBorder {
	border-bottom:3px solid #00738F;
	padding-bottom:5px;
}
.mainContent .forBackground {
	background-color:#EBE9EA;
	margin:10px 0;
	border:1px solid #D9D9D9;
}
.mainContent p {
	font-size: 0.875em;
}
/* =================== start of index mainContent ===================*/

/*  for most popular section */
.mainContent section h5, .mainContent section h5 {
	background-color:#ccc;
	padding:5px;
	margin-top:0;
	margin-bottom:0;
}
.mainContent section.mostPopular .panel {
	margin-top:10px;
	
}
.mainContent section.mostPopular .panel a.playBtn{
	background:url(../img/play_btn.png) center no-repeat ;
	display:block;
	position:absolute;
	top:0;
	left:0;
	height:100%;
	width:100%;
}
.mainContent section.mostPopular .panel:hover {
	border:1px outset #ccc;
}
/*  end of most popular section */

/* for login from */
.mainContent section.loginForm {
	margin-top:10px;
	border:1px solid #D9D9D9;
	background-color:#EBE9EA;
}
.mainContent section.loginForm form {
	margin:0;
}
.mainContent section.loginForm form fieldset {
	border:0;
	margin:0;
	padding-bottom:0;
	padding-top:0;
}
.mainContent section.loginForm form .forgotPwd {
	text-decoration:underline;
}
.mainContent section.loginForm form p, section.loginForm form p button {
	margin-bottom:0;
}
.mainContent section.loginForm form p button {
	margin-right:5%;
}
/* end of login from */
/* for intro */
.mainContent .intro {
	padding:3%;
}
.mainContent .introVideo {
	padding:3%;
}
.mainContent .introVideo p img { margin-right:4%; }

/* =================== end of main content *================*/
/* =================== end of index mainContent ===================*/

/* =================== Start of registaration mainContent ===================*/

.mainContent .registrationForm {
	margin:3%;
}
.mainContent .registrationForm fieldset {
	border:0;
}
/* =================== end of registaration mainContent ===================*/


/* =================== start  of user  page===================*/
/* =================== end   of user  page===================*/
.mainContent .presentVideo {
	position:relative;
}
.mainContent .presentVideo  video {
	border:1px solid black;
}


.mainContent .presentVideo  #footnote {
	width:490px;
	background-color:rgba(0,102,151,.5);
	position:absolute;
	color:#FFF;
	display:none;
	padding:1%;
	border:1px solid #FFF;
	border-radius:3px;
	bottom: 5px;
	box-sizing:border-box;
	-moz-box-sizing:border-box;
	-webkit-box-sizing:border-box;
	margin-left:5px;
	
}
#wrapper .mainContent input[id="userSearch"] {background: url(../img/search.png) right center no-repeat;background-color: transparent; }
#wrapper .mainContent section.mostViewed .large-12,#wrapper .mainContent section.recents .large-12{
	padding:3px;
}

#wrapper .mainContent section.mostViewed .panel,#wrapper .mainContent section.recents .panel {
	padding:5px 0 0 0;
	margin-bottom:0;
	margin-top:2px;
}
.mainContent section.mostViewed .desc{
	font-size:0.9em;
}
/* =================== start of TutorPage *================*/
/* =================== left form section css *================*/
.mainContent section.addedTurorials table {
	width:100%;
}
.mainContent section.addedTurorials table th,.mainContent section.addedTurorials table td {
	width:20%;
}
.mainContent .leftForm {
	width:100%;
	margin:2% auto;
	
}
.mainContent .leftForm h5 {
	text-align:center;
}
.mainContent .forUpload {
	width:92%;
	margin:1% auto;
}
.mainContent .leftForm label {
	padding:3% 0%;
	color:#0062C4;
}
/* =================== left form section css end*================*/
/* =================== right form section css *================*/
.mainContent .rightForm {
	width:98%;
	margin:6% auto;
	border:#00738F solid thin;
	
}
.mainContent .rightForm h5 {
	text-align:center;
}
.mainContent .rightForm label {
	padding:3% 0%;
	color:#0062C4;
}
.mainContent input {
	margin-left:0%;
	font-size:14px;
}
.mainContent select {
	font-size:14px;
}
/* =================== right form section css end*================*/
/* =================== button section css *================*/
.buttonSection {
	widows:100%;
}
.buttonMiddle {
	margin-left:3%;
}
/* =================== button section css *================*/
/* =================== end of TutorPage *================*/
/*====================start of AssessmentPage================*/

.technology{margin:10% auto 5% auto;border:1px solid black;text-align:center;}

.technology .side-nav li.divider{border-top:1px solid #000;}
.forPad{padding:0 0 0 1.5;}
.assessment{margin:5% auto 0% auto;}
.assessment h5{text-align:center;color:#6A6A6A;}
.assessment p{border:1px solid black;color:#5C5C5C;text-align:center;padding:3%;width:96%;margin:5% auto;}
.assessment p .start{display:block;margin-top:10%;}
.assessment p button.small, .button.small .startbutton{margin:0% 5%;}

/*===============end of AssessmentPage===========*/
footer {
	background-color:#EBE9EA;
	border-top:3px solid #D6D4D5;
}
 @media all and (min-width : 768px) {
header nav {
	text-align:left;
	padding-top:10px;
}
header nav ul {
	float:right;
	margin-bottom:10px;
}
header nav ul li {
	float:left;
	background:none;
	margin:0;
}
header nav ul li a {
	border-left:1px solid #AAA;
}
header .mainSearch form {
	float:right
}
/* =================== start of TutorPage css for ipad  *================*/
.mainContent  .leftForm{font-size:80%;}
.mainContent  .leftForm h5{margin-bottom:5%;}
.mainContent  .rightForm {
	
	width:100%;
	font-size:80%;
}
.mainContent  .forUpload {
	width:98%;
	margin:2% auto;
	padding:0% 2%;
}
.mainContent  .buttonSection {
	font-size:80%;
}
/* =================== end of TutorPage css for ipad  *================*/
.forPad{padding:0 ;}
}
@media all and (min-width : 1024px) {
/* =================== start of TutorPage css for descktop  *================*/
.mainContent  .rightForm {
	width:90%;
	font-size:100%;
}
.mainContent  .leftForm {font-size:100%;}
.mainContent  .leftForm input[type='file'] {
	width:100%;
	
}
.mainContent  .buttonSection {
	font-size:100%;
}
/* =================== start of TutorPage css for desktop  *================*/
}
