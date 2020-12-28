const fs = require('fs');
const axios = require('axios');
const zlib = require('zlib');
const { exec } = require("child_process");
let videoName = process.env.videoName;


console.log('videoName', videoName);

const execCommand = async function (command) {
	return new Promise(res => {
		try {
			exec(command, (error, stdout, stderr) => {
			    if (error) {
			        console.log(`error: ${error.message}`);
			    }
			    if (stderr) {
			        // console.log(`stderr: ${stderr}`);
			    }
			    res(1);
			});
		}

		catch(error) {
			console.log('error', error);
			res(1);
		}
	})
}
const main = async function() {
	let allData  = fs.readFileSync('./m3u8s/'+videoName+ '.m3u8', 'utf-8').split('\n').filter(t => t.match(/^http/));
	console.log('allData', allData.length);
	let t = '';
	let num = 0;
	await execCommand(`rm -rf ${videoName}-*.mpeg`);
	let queue = [];
	for (const url of allData) {
		try {
			let command = `curl '${url}' \
			  -H 'authority: slave.reviewphimhay.com' \
			  -H 'origin: https://loadbalancer.gigaphim.com' \
			  --compressed > ${videoName}-${num}.mpeg`;
			 
			queue.push(execCommand(command));
			num ++;

			if (queue.length > 100) {
				await Promise.all(queue);
				queue = [];
			}
			console.log(num / allData.length * 100, '%');
		} catch(error) {
			console.log('error', error);
		}
	}
	await Promise.all(queue);
	for (let i=0; i <= num; i++) {
		command = `cat ${videoName}-num.mpeg >> ${videoName}.mpeg`;
		execCommand(command);
	}

	process.exit();
};

main();