const vsda_location = "vsda.node";
const a = require(vsda_location);
const signer = new a.signer();
process.argv.forEach((value, index) => {
    if (index >= 2) {
        const r = signer.sign(value);
        console.log(r);
    }
});
