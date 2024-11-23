const http = require('node:http');
const process = require('node:process');

const server = new http.Server();

const port = process.env.PORT || 8080;
const response = process.env.RESPONSE || 'hello world!';

server.on('request', (req, res) => {
    logInfo(`${req.method} ${req.url}`);
    res.write(`${response}\n`);
    res.end();
});

server.on("error", (error) => {
    logInfo(`Server error:`);
    logError(error);
});

server.on("close", () => {
    logInfo(`Server closed`);
});

server.listen({ port }, () => {
    logInfo(`Server listening on port ${port}`);
});

const shutdown = () => {
    logInfo('Server shutdown begin');
    server.close(() => {
        logInfo('Server shutdown complete');
    });
};

// With Dockerfile entrypoint specified as ENTRYPOINT ["command", "arg1, "arg2"]
// our node process gets run as PID 1. This means don't inherit default signal
// handlers and have to handle them ourself. We don't have to do this if we use
// the docker run --init option.
// https://hynek.me/articles/docker-signals/
// https://engineeringblog.yelp.com/2016/01/dumb-init-an-init-for-docker.html
const onTerminalInterrupt = (signal) => {
    logInfo(`recieved signal ${signal}`);
    logInfo('terminal issued stop');
    shutdown();
};

const onProcessTerminated = (signal) => {
    logInfo(`recieved signal ${signal}`);
    logInfo('process terminated');
    shutdown();
};

const onTerminalConnectionLost = (signal) => {
    logInfo(`recieved signal ${signal}`);
    logInfo('terminal connection lost');
    shutdown();
};

// Signals generated from terminal by typing characters.
process.on('SIGINT', onTerminalInterrupt);
process.on('SIGQUIT', onTerminalInterrupt);
// Process will be terminated
process.on('SIGTERM', onProcessTerminated);
// Terminal connection lost
process.on('SIGHUP', onTerminalConnectionLost);

const logInfo = (msg) => {
    console.log(`${getTimeStamp()} ${msg}`);
};
const logError = (error) => {
    console.error(`${getTimeStamp()} ${error}`);
};

const getTimeStamp = () => {
    const now = new Date();
    const paddedMonth = padZerosLeft(now.getUTCMonth()+1, 2);
    const paddedDate = padZerosLeft(now.getUTCDate(), 2);
    const paddedHours = padZerosLeft(now.getUTCHours(), 2);
    const paddedMinutes = padZerosLeft(now.getUTCMinutes(), 2);
    const paddedSeconds = padZerosLeft(now.getUTCSeconds(), 2);
    const paddedMilliseconds = padZerosRight(now.getUTCMilliseconds(), 3);
    const formattedDate = `${now.getUTCFullYear()}-${paddedMonth}-${paddedDate}`;
    const formattedTime = `${paddedHours}:${paddedMinutes}:${paddedSeconds}.${paddedMilliseconds}`;
    return `${formattedDate}T${formattedTime}Z`;
}

const padZerosLeft = (input, length) => {
    let inputStr = input.toString();
    if (inputStr.length >= length) {
        return inputStr;
    }
    const numPadding = length - inputStr.length;
    for (let i = 0; i < numPadding; i++) {
        inputStr = '0' + inputStr;
    }
    return inputStr;
}

const padZerosRight = (input, length) => {
    let inputStr = input.toString();
    if (inputStr.length >= length) {
        return inputStr;
    }
    const numPadding = length - inputStr.length;
    for (let i = 0; i < numPadding; i++) {
        inputStr = inputStr + '0';
    }
    return inputStr;

}
