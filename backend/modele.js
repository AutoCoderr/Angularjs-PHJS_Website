"use strict";

const mysql = require("mysql");

module.exports = class Modele {
	constructor(host, user, password, database)  {
		this.conn = mysql.createConnection({
			host: host,
			user: user,
			password: password,
			database: database
		});

		this.conn.connect();
	}

	select(columns, tables, conditions = "1 = 1", callback) {
		if (conditions === "") {
			conditions = "1 = 1";
		}
		this.conn.query('SELECT '+columns+' FROM '+tables+' WHERE '+conditions, function (error, results, fields) {
			if (error) {
				callback(error);
				return;
			}
			callback(null, results);
		});
	}

	insert(table, datas, callback) {
		let datasStr = "";
		for (let i=0;i<datas.length;i++) {
			if (typeof(datas[i]) === "string") {
				datasStr += "'"+datas[i]+"'";
			} else {
				datasStr += datas[i];
			}
			if (i < datas.length-1) {
				datasStr += ", ";
			}
		}
		this.conn.query("INSERT INTO "+table+" VALUE ("+datasStr+")", function (error, result) {
			if (error) {
				callback(error,result);
				return;
			}
			callback(null,result);
		});
	}

	delete(table,conditions = "1 = 1", callback) {
		if (conditions === "") {
			conditions = "1 = 1";
		}

		this.conn.query("DELETE FROM "+table+" WHERE "+conditions, function (error, result) {
			if (error) {
				callback(error);
				return;
			}
			callback(null);
		});
	}

	update(table,sets,conditions = "1 = 1", callback) {
		if (conditions === "") {
			conditions = "1 = 1";
		}

		let setStr = "";
		for (let key in sets) {
			if (typeof(sets[key]) === "string") {
				setStr += key+" = '"+sets[key]+"'";
			} else {
				setStr += key+" = "+sets[key];
			}
			setStr += ", ";
		}
		setStr = setStr.substring(0,setStr.length-2);

		this.conn.query("UPDATE "+table+" SET "+setStr+" WHERE "+conditions, function (error, result) {
			if (error) {
				callback(error);
				return;
			}
			callback(null);
		});
	}

};