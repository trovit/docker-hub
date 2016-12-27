// Description:
//   parsing5 service runner
//
// Dependencies:
//   None
//
// Configuration:
//   None
//
// Commands:
//   hubot extract title from http://google.es - returns Google

module.exports = function(robot) {

// More examples:
//   hubot extract h1:first from trovit.com - returns A search engine for classified ...
//   hubot extract h3.r a from google.com/search?q=nikochan - 1.- King Nikochan ...
//   hubot extract h3.r a with href from google.com/search?q=nikochan - 1.- http:// ...
//   hubot extract h3.r a with href,innerText from google.com/search?q=nikochan - 1.- href: http:// ...
//
//   hubot html from google.com
//   hubot the html from google.com
//   hubot get html from google.com

	//var p5service = 'http://vm-test-parsing-01.backend:50001/' ;
	var p5service = 'http://vpc-parsing5server-02.vpc:50000/' ;
	var p5502     = '<html><body><h1>502 Bad Gateway' ;

	function p5handler(query,fnc,fncf,retry) {
		robot.http(query).get()(function(err, res, body){
			if(err || body.indexOf(p5502)!=-1){
				if(retry){
					console.log('rety ...',retry);
					p5handler(query,fnc,fncf,--retry);
				}
				else {
					fncf();
				}
			}
			else {
				fnc( err, res, body);
			}
		});
	}

	function p5extractor( msg, site, css, attr, fnc) {
		var url = p5service + 'extract/?url=$1&args={"win":{"css":"$2","attr":"$3"}}' ;
		var query = url.replace(/\$1/,site).replace(/\$2/,css).replace(/\$3/,attr.join(',')) ;

		console.log('p5extractor:',site,css,query,attr);
		p5handler(query,fnc,function(){ msg.send("Can't, I'm busy :("); },3);
		//robot.http(query).get()(fnc);
	}

	function p5getHtml( msg, site, fnc) {
		var url = p5service + 'get_html/?url=$1' ;
		var query = url.replace(/\$1/,site) ;

		console.log('p5getHtml:',site,query);
		p5handler(query,fnc,function(){ msg.send("Can't, I'm busy :("); },3);
		//robot.http(query).get()(fnc);
	}

	robot.respond(/(extract) ((?:(?! with).)*)(?: with (.*))? from (.*)/i, function(msg)
	{
		//console.log(msg.match);
		var cmd  = msg.match[1].trim() ;
		var css  = encodeURIComponent(msg.match[2].trim()) ;
		var site = clearUrl(msg.match[4]);
		var attr = ['innerText'/*'innerHTML'*/] ;

		if(typeof(msg.match[3])!='undefined'){
			var attr = msg.match[3].trim().split(',');
		}

		switch(cmd) {
			case 'extract':
				p5extractor(msg,site,css,attr,function(err, res, body) {
					if(err || body.indexOf(p5502)!=-1){
						msg.send("Can't, I'm busy :(");
						return;
					}

					console.log('body',body);
					var obj = JSON.parse(body);
					if(obj.win == ''){
						msg.send('Nothing found :(');
					}
					else {
						var allMsg = [] ;
						for(var k in obj.win){
							allMsg.push( ((obj.win.length==1)? '' : (parseInt(k)+1)+'.- ') + printObj(obj.win[k]) );
						}
						msg.send( allMsg.join("\n") );
					}
				});
				break;

			//case 'get_title':
			//case 'get_stack':
		}
	});

	robot.respond(/(?:the |get )?html from (.*)/i, function(msg)
	{
		var url = clearUrl(msg.match[1]);
		p5getHtml(msg,url,function(err, res, body) {
			if(err || body.indexOf(p5502)!=-1){
				msg.send("Can't, I'm busy :(");
				return;
			}

			msg.send(body);
		});
	});

	function clearUrl( url) {
		var site = url.trim() ;
		if(!site.match(/^https?:\/\//)){
			site = 'http://' + site ;
		}

		// fix double protocols from slack
		site = site.replace(/(https?:\/\/)+/,'$1');
		return encodeURIComponent(site) ;
	}

	function printObj(obj) {
		//console.log('printObj',obj);
		if(typeof(obj)=='string'){
			return obj.trim() ;
		}

		var str = [] ;
		if(Object.keys(obj).length==1){
			for(var k in obj){
				str.push(obj[k].trim());
			}
		}
		else {
			for(var k in obj){
				str.push(k + ': ' + obj[k].trim());
			}	
		}

		return str.join(', ');
	}
}