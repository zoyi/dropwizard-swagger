<#-- @ftlvariable name="" type="com.federecio.dropwizard.swagger.SwaggerView" -->
<!DOCTYPE html>
<html>
<head>
  <title>Swagger UI</title>
  <link href='${swaggerAssetsPath}/css/typography.css' media='screen' rel='stylesheet' type='text/css'/>
  <link href='${swaggerAssetsPath}/css/reset.css' media='screen' rel='stylesheet' type='text/css'/>
  <link href='${swaggerAssetsPath}/css/screen.css' media='screen' rel='stylesheet' type='text/css'/>
  <link href='${swaggerAssetsPath}/css/reset.css' media='print' rel='stylesheet' type='text/css'/>
  <link href='${swaggerAssetsPath}/css/screen.css' media='print' rel='stylesheet' type='text/css'/>
  <script src='${swaggerAssetsPath}/lib/jquery-1.8.0.min.js' type='text/javascript'></script>
  <script src='${swaggerAssetsPath}/lib/jquery.slideto.min.js' type='text/javascript'></script>
  <script src='${swaggerAssetsPath}/lib/jquery.wiggle.min.js' type='text/javascript'></script>
  <script src='${swaggerAssetsPath}/lib/jquery.ba-bbq.min.js' type='text/javascript'></script>
  <script src='${swaggerAssetsPath}/lib/handlebars-2.0.0.js' type='text/javascript'></script>
  <script src='${swaggerAssetsPath}/lib/underscore-min.js' type='text/javascript'></script>
  <script src='${swaggerAssetsPath}/lib/backbone-min.js' type='text/javascript'></script>
  <script src='${swaggerAssetsPath}/swagger-ui.js' type='text/javascript'></script>
  <script src='${swaggerAssetsPath}/lib/highlight.7.3.pack.js' type='text/javascript'></script>
  <script src='${swaggerAssetsPath}/lib/marked.js' type='text/javascript'></script>

    <!-- enabling this will enable oauth2 implicit scope support -->
  <script src='${swaggerAssetsPath}/lib/swagger-oauth.js' type='text/javascript'></script>
  <script type="text/javascript">
    $(function () {
      window.swaggerUi = new SwaggerUi({
        url: "${contextPath}/swagger.json",
        dom_id: "swagger-ui-container",
        supportedSubmitMethods: ['get', 'post', 'put', 'delete'],
        onComplete: function(swaggerApi, swaggerUi){
          if(typeof initOAuth == "function") {
            /*
            initOAuth({
              clientId: "your-client-id",
              realm: "your-realms",
              appName: "your-app-name"
            });
            */
          }
          $('pre code').each(function(i, e) {
            hljs.highlightBlock(e)
          });
        },
        onFailure: function(data) {

        },
        docExpansion: "none",
        sorter : "alpha"
      });

      function addApiKeyAuthorization() {
        var key = $('#input_apiKey')[0].value;
        if(key && key.trim() != "") {
            swaggerUi.api.clientAuthorizations.add("api_key", new SwaggerClient.ApiKeyAuthorization("api_key", key, "query"));
        }
      }

      function addManagerAuthorization() {
        var key = $('#input_ManagerId')[0].value;
        if(key && key.trim() != "") {
          swaggerUi.api.clientAuthorizations.add("X-Manager-Id", new SwaggerClient.ApiKeyAuthorization("X-Manager-Id", key, "header"));
        } else {
          swaggerUi.api.clientAuthorizations.remove("X-Manager-Id");
        }

        var key = $('#input_ManagerToken')[0].value;
        if(key && key.trim() != "") {
          swaggerUi.api.clientAuthorizations.add("X-Manager-Token", new SwaggerClient.ApiKeyAuthorization("X-Manager-Token", key, "header"));
        } else {
          swaggerUi.api.clientAuthorizations.remove("X-Manager-Token");
        }
      }
      function addUserAuthorization() {
        var key = $('#input_UserId')[0].value;
        if(key && key.trim() != "") {
          swaggerUi.api.clientAuthorizations.add("X-User-Id", new SwaggerClient.ApiKeyAuthorization("X-User-Id", key, "header"));
        } else {
          swaggerUi.api.clientAuthorizations.remove("X-User-Id");
        }
        var key = $('#input_UserToken')[0].value;
        if(key && key.trim() != "") {
          swaggerUi.api.clientAuthorizations.add("X-User-Token", new SwaggerClient.ApiKeyAuthorization("X-User-Token", key, "header"));
        } else {
          swaggerUi.api.clientAuthorizations.remove("X-User-Token");
        }
      }

      function addAuthorizationHeader() {
          var key = $('#input_authHeader')[0].value;
          if(key && key.trim() != "") {
              swaggerUi.api.clientAuthorizations.add("Custom Authorization", new SwaggerClient.ApiKeyAuthorization("Authorization", key, "header"));
          }
      }

      $('#input_apiKey').change(function() {
          addApiKeyAuthorization();
      });

      $('#input_ManagerId').change(function() {
          addManagerAuthorization();
      });
      $('#input_ManagerToken').change(function() {
          addManagerAuthorization();
      });
      $('#input_UserId').change(function() {
          addUserAuthorization();
      });
      $('#input_UserToken').change(function() {
          addUserAuthorization();
      });

      $('#input_authHeader').change(function() {
          addAuthorizationHeader();
      });

      $('#input_headerSelect').change(function() {
          var toShow = $( this ).val();
          for (var i = 0; i < 4; ++i) {
            if (i != Number(toShow)) {
              $('#header_'+i).hide();
            }
          }
          $('#header_'+toShow).show();
      });
      // if you have an apiKey you would like to pre-populate on the page for demonstration purposes...
      /*
        var apiKey = "myApiKeyXXXX123456789";
        $('#input_apiKey').val(apiKey);
        addApiKeyAuthorization();
      */

      window.swaggerUi.load();
  });
  </script>
</head>

<body class="swagger-section">
<div id='header'>
  <div class="swagger-ui-wrap">
    <a id="logo" href="http://swagger.io">swagger</a>
    <form id='api_selector'>
      <div class='input'><input placeholder="http://example.com/api" id="input_baseUrl" name="baseUrl" type="text"/></div>
      <div class='input'>
          <select id="input_headerSelect">
              <option value="0">User Auth</option>
              <option value="1">Manager Auth</option>
              <option value="2">api_key</option>
              <option value="3">Auth Header</option>
          </select>
      </div>
      <div class='input' id="header_0">
        <input placeholder="ID" id="input_UserId" name="UserId" size="3" type="text"/>
        <input placeholder="Token" id="input_UserToken" name="UserToken" size="10" type="text"/>
      </div>
      <div class='input' id="header_1" style="display: none;">
        <input placeholder="ID" id="input_ManagerId" name="ManagerId" size="3" type="text"/>
        <input placeholder="Token" id="input_ManagerToken" name="ManagerToken" size="10" type="text"/>
      </div>
      <div class='input' id="header_2" style="display: none;"><input placeholder="api_key" id="input_apiKey" name="apiKey" type="text"/></div>
      <div class='input' id="header_3" style="display: none;"><input placeholder="Basic ..." id="input_authHeader" name="authHeader" type="text"/></div>
      <div class='input'><a id="explore" href="#">Explore</a></div>
    </form>
  </div>
</div>

<div id="message-bar" class="swagger-ui-wrap">&nbsp;</div>
<div id="swagger-ui-container" class="swagger-ui-wrap"></div>
</body>
</html>
