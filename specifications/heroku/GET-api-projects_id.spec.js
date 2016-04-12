'use strict';

var
  assert = require('chai').assert,
  spec   = require('api-first-spec'),
  heroku = require('./heroku'),
  appname = require('../../account.json').heroku_appname;

var API = spec.define({
  "endpoint": "/api/projects/[id]",
  "method": spec.Method.GET,
  "request": {
    "contentType": spec.ContentType.URLENCODED,
    "data": {
      "id": "int"
    }
  },
  "response": {
    "contentType": spec.ContentType.JSON,
    "data": "any"
  }
});

describe("GET /api/projects/:id", function () {
  function create (callback) {
    var options = {
      url: "https://" + heroku.endpoint(appname, '/api/projects'),
      method: "POST",
      json: true,
      form: {
        title: "Lorem",
        url: "https://example.com",
        description: "Lorem ipsum"
      }
    };
    require('request')(options, callback);
  }
  before(function (done) {
    create(function (err, resp, body) {
      project.id = body.id;
      project.title = body.title;
      project.url = body.url;
      project.description = body.description;
      done();
    });
  });

  var project = {};
  var host = spec.host(heroku.origin(appname));

  it("should be not found if not exists", function (done) {
    host.api(API).params({
      id: -1
    }).notFound(done);
  });

  it("should succeed if exsits", function (done) {
    host.api(API).params({
      id: project.id
    }).success(done);
  });

});
