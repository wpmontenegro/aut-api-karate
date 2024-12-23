function fn() {
  var env = karate.env; // get java system property 'karate.env'
  karate.log('karate.env system property was:', env);

  // environments variables
  var systemPath = java.lang.System.getenv('PATH');
  var clientId = java.lang.System.getenv('AUTH0_CLIENT_ID');
  var clientSecret = java.lang.System.getenv('AUTH0_CLIENT_SECRET');

  if (!env) {
    env = 'qa'; // a custom 'intelligent' default
  }
  var config = { // base config JSON
    baseUrl: "https://reqres.in/",
    auth0Url: "https://dev-kjcagkyhdg5lkbmg.us.auth0.com",
    clientId: clientId,
    clientSecret: clientSecret
  };
  if (env == 'dev') {
    // over-ride only those that need to be
    baseUrl = "https://reqres-dev.in/",
    auth0Url = "https://dev-kjcagkyhdg5lkbmg.us.auth0.com"
  }

  // don't waste time waiting for a connection or if servers don't respond within 5 seconds
  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);
  karate.configure('ssl', true);
  return config;
}