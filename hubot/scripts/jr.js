// Description:
//   JR
//
// Dependencies:
//   None
//
// Configuration:
//   None
//
// Commands:
//   sasha jr me Gracias

module.exports = function(robot) {
	robot.respond(/jr(?: )?me (.*)/i, function(msg) {
		var jrurl = msg.match[1].trim().replace(/\\n/ig,"\n") ;
		var size  = 50 ;
		return msg.send("http://design.office/trollme/?string="+encodeURIComponent(jrurl)+'&size='+size+'&x.png');
	});
};