var mysql = require('mysql');
const readline = require('readline');

const rl = readline.createInterface({
	input: process.stdin,
	output: process.stdout
});

console.clear();
rl.on('line', (input) => {
	console.clear();
	var sql = {sql: input, nestTables: '_'};
  	query(sql);
});


const query = function(sql) {

	var con = mysql.createConnection({
	host: "mysql679.loopia.se",
	user: "filip@a244459",
	password: "p@lmQv1$t",
	database: "ansigroup_se"
	});

	con.query(sql, function(err, result, fields) {
		if (err) console.log(err.sqlMessage);
		else if (result) handleResult(result);
		else console.log("no data recieved.");
	});

	con.end();
}

const handleResult = function(result) {
	if (result["FieldPacket"] > 0) console.log(true);

	console.log(result);


}