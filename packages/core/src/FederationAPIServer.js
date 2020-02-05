const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const Client = require('./Client');
const log4js = require(`log4js`);

const logger = log4js.getLogger(`FederationAPIServer`);
logger.level = `DEBUG`;

class FederationAPIServer {
  constructor(options = {}) {
    const { bifApiPort } = options;
    this.bifApiPort = bifApiPort;
    if (!isFinite(this.bifApiPort)) {
      throw new TypeError(`FederationAPIServer#ctor options.bifApiPort non-finite: ${this.bifApiPort}`);
    }
    this.app = express();
    this.app.options('*', cors());
    this.app.use(cors());
    this.app.use(bodyParser.json());
    this.app.use(bodyParser.urlencoded({ extended: true }));

    this.app.post('/ask-for-signatures', async (req, res) => {
      try {
        const { assetId, targetDLTId, validators } = req.body;
        logger.debug({ assetId, targetDLTId, validators });
        // TODO replace by equivalent call "received a sign request"
        const federationClient = new Client({ validators });
        const multiSignature = await federationClient.askForSignatures(assetId, targetDLTId);
        logger.info('Signatures are:', JSON.stringify(multiSignature.signatures));
        res.json(multiSignature);
      } catch (ex) {
        logger.error(`POST /ask-for-signatures request => `, ex);
        res.status(500);
        res.json({error: true, stack: ex.stack});
      }
    });
  }
  async startApiServer() {
    return new Promise((resolve) => {
      this.httpServer = this.app.listen(this.bifApiPort, () => {
        resolve();
        console.log(`Validator API server listening on port ${this.bifApiPort}!`);
      });
    })
  }

  async stopApiServer() {
    if (this.httpServer) {
      return new Promise((resolve, reject) => {
        if (!this.httpServer.listening) {
          resolve();
        } else {
          this.httpServer.close((err) => {
            if (err) {
              logger.error(`Failed to shut down the Federation API Server: `, err);
              reject(err);
            } else {
              resolve();
            }
          });
        }
      });
    }
  }
}

module.exports = FederationAPIServer;
