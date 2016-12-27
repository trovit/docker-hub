// Description:
//   code runner
//
// Dependencies:
//   None
//
// Configuration:
//   None

module.exports = function(robot)
{
	// Commands:
	//   hubot run code <? echo "Hello World" ?> with php - Hello World
	//	 hubot run code <? $a=array('@jordi9','world','hello');while($w=array_pop($a)) echo $w.' ' ; ?>

	robot.respond(/(run code) ((?:(?! with).)*)(?: with (.*))?/i, function(msg)
	{
		var cmd  = msg.match[1].trim() ;
		var code = msg.match[2].trim() ;
		var lang = 'php' ;

		if(typeof(msg.match[3])!='undefined'){
			var lang = msg.match[3].trim();
		}

		console.log('params:',cmd,code,lang);
		codePad( msg, code, lang, function(result,url){
			console.log('result:',result,'from:',url);
			for(var k in result){
				msg.send( k + '.- ' + result[k] );
			}
		});
	});

	function codePad(msg,code,lang,fnc) {
		var url  = 'http://codepad.org/' ;
		var data = {
			'lang'    : lang.toUpperCase(),
			'code'    : code,
			'run'     : 'True',
			'private' : 'True',
			'submit'  : 'Submit',
		};

		var params = serialize(data);
		//console.log('url',url,'data',data,'params',params);

		robot
			.http(url)
			.headers({
				"Accept:": "*/*",
				"Content-Type": "application/x-www-form-urlencoded",
				"Content-Length": params.length
			})
			.post(params)(function(err, res, body){
				var pad = res.headers.location ;
				if(err) msg.send("Can't. Service busy :(");
				else {
					var css  = '.code .highlight:last pre' ;
					var attr = ['innerText'];
					var p5service = new p5();
					p5service.extractor(msg,pad,css,attr,function(err, res, body) {
						if(err || body.indexOf(p5service.errorMsg())!=-1){
							console.log( 'errorMsg:', p5service.errorMsg() );
							msg.send("Can't, I'm busy :(");
							return;
						}

						var obj = JSON.parse(body);
						if(obj.win == ''){
							msg.send('Empty :(');
						}
						else {
							var result = obj.win[0].innerText.split("\n") ;
							fnc(result,pad);
						}
					});
				}
			});
	}

	var p5 = function()
	{

		//this.service = 'http://vpc-parsing5server-02.vpc:50000/' ;
		this.service = 'http://vm-test-parsing-01.backend:50001/' ;
		this.p5502   = '<html><body><h1>502 Bad Gateway' ;
		this.handler = null;

		this.handler = function (query,fnc,fncf,retry) {
			robot.http(query).get()(function(err, res, body){
				if(err || body.indexOf(this.p5502)!=-1){
					if(retry){
						console.log('rety ...',retry);
						this.handler(query,fnc,fncf,--retry);
					}
					else {
						fncf();
					}
				}
				else {
					fnc( err, res, body);
				}
			}.bind(this));
		}.bind(this);

		this.errorMsg = function(){
			return this.p5502 ;
		}

		this.extractor = function ( msg, site, css, attr, fnc) {
			var url   = this.service + 'extract/?url=$1&args={"win":{"css":"$2","attr":"$3"}}' ;
			var query = url.replace(/\$1/,site).replace(/\$2/,css).replace(/\$3/,attr.join(',')) ;

			console.log('p5extractor:',site,css,query,attr);
			this.handler(query,fnc,function(){ msg.send("Can't, I'm busy :( (3)"); },3);
		}
	}

	function serialize(obj) {
	   var str = [];
	   for(var p in obj){
	       if (obj.hasOwnProperty(p)) {
	           str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
	       }
	   }

	   return str.join("&");
	}
}