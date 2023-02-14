function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiURL: 'https://api.realworld.io/api/'
  }
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
    config.userEmail = "qweeweweqweqweqs123123eqwe@qweqwe.com";
    config.userPassword = "qweqweqweqwe";
  } else if (env == 'QA') {
    config.userEmail = "qweeweweqweqweqs123123eqwe@qweqwe.com";
    config.userPassword = "qweqweqweqwe";
  }

  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
  karate.configure('headers', {Authorization: 'Token '+accessToken})
  
  karate.configure('connectTimeout', 15000);
  karate.configure('readTimeout', 15000);
  
  return config;
}
