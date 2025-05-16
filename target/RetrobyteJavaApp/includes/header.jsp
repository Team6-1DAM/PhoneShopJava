<!doctype html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Album example · Bootstrap v5.3</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="./styles.css" rel="stylesheet"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Teachers:ital,wght@0,400..800;1,400..800&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<%
    HttpSession currentSession = request.getSession();
    String role = "anonymous";
    String username_init ="";
    int user_id=0;
    if (currentSession.getAttribute("role") != null) {
        role = currentSession.getAttribute("role").toString();
    }
    if (currentSession.getAttribute("username") != null) {
        username_init = currentSession.getAttribute("username").toString();
    }
    if (currentSession.getAttribute("id_user") != null) {
        user_id=Integer.parseInt(currentSession.getAttribute("id_user").toString());
    }
%>
<body class="bg-image">

<header>

    <div>
        <div class="header-class">
            <img src="./icons/RetroByte logo.png" alt="Logo de Empresa" width="10%">
            <div class="container-title">
                <h1>Retrobyte</h1>
            </div>
            <div class="login-signin">
                <a href="#" class="signin-line"></a>
                <a href="#" class="signin-line"></a>
            </div>
        </div>

    </div>

</header>