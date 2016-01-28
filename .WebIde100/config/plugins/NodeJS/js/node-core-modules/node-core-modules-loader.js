var coreModulePaths = Array.prototype.slice.call(process.argv, 2);
var successCount = 0;
coreModulePaths.forEach(function (coreModulePath) {
    try {
        var codeModule = require(coreModulePath);
        successCount++;
        console.log('Loaded ' + coreModulePath);
    }
    catch (err) {
        console.error('FAILED' + coreModulePath, err);
    }
});

console.log('@debugger: core modules has been loaded, ready for communication');
process.stdin.resume();
