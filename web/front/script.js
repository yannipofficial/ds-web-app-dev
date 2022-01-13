
// Fortwsi twn Authors sto <select>
const renderAuthors = (authors) => {
  var select = document.getElementById("selectFilter");
  const optionTemplate = document.getElementById("option-template");
  for (const author of authors) {
    const optionEl = optionTemplate.content.cloneNode(true);
    optionEl.querySelector(".authorOption").innerText = author.author;
    optionEl.querySelector(".authorOption").value = author.usersid;
    select.appendChild(optionEl);
  }
};

// Fortwsi twn posts sto postsContainer
function getPosts(userId) {
  const renderPosts = (posts, clear = false) => {
    const postsContainer = document.getElementById("posts-list");
    const postTemplate = document.getElementById("post-template");
    if (clear) {
      postsContainer.innerHTML = "";
    }
    for (const post of posts) {
      const postEl = postTemplate.content.cloneNode(true);

      postEl.querySelector(".card-title").innerText = post.title;
      postEl.querySelector(".card-subtitle").innerText =
        "by " + post.author + " at " + post.addedat;
      postEl.querySelector(".card-text").innerText = post.content;
      postsContainer.appendChild(postEl);
    }
  };

// Request sto api gia ta posts (eite me userid, eite xwris)

  fetch(
    "http://localhost/web/back/api/posts.php" + (userId ? "?id=" + userId : "")
  )
    .then((response) => {
      return response.json();
    })
    .then((data) => {
      renderPosts(data, true);
    })
    .catch((error) => {
      console.log(error);
    });
}

// Request sto api gia tous authors

fetch("http://localhost/web/back/api/postAuthors.php")
  .then((response) => {
    return response.json();
  })
  .then((data) => {
    renderAuthors(data);
  })
  .catch((error) => {
    console.log(error);
  });


// To function pou kaleite otan ginetai kapoio selection sto <select>

function selectAuthor() {
  const userId = document.getElementById("selectFilter").value;
  getPosts(userId);
}

// POST ena neo post pou kanei o xristis

const savePost = (title, content) => {
  return fetch("http://localhost/web/back/api/sendPost.php", {
    method: "POST",
    body: JSON.stringify({
      title,
      content,
    }),
  }).then((response) => {
    return response.json();
  });
};

// POST gia na kanei login o xristis

const login = (username, password) => {
  return fetch("http://localhost/web/back/api/login.php", {
    method: "POST",
    body: JSON.stringify({
      username,
      password,
    }),
  }).then((response) => {
    return response.json();
  });
};

// POST gia na kanei logout o xristis

function logout(){
  return fetch("http://localhost/web/back/api/logout.php", {
    method: "POST",
  }).then((response) => {
    return response.json();
  });
};

// UI kai functionality

document.addEventListener("DOMContentLoaded", function () {
  const loginForm = document.getElementById("login");
  loginForm.style.display = "none";
  getPosts();
  const submitPostButton = document.getElementById("submit-post-form");
  submitPostButton &&
    submitPostButton.addEventListener("click", function (event) {
      event.preventDefault();
      const postTitle = document.getElementById("post-title");
      const postContent = document.getElementById("post-content");
      savePost(postTitle.value, postContent.value).then((result) => {
        getPosts(0);
        postTitle.value = "";
        postContent.value = "";
      });
    });

    const loginToggleButton = document.getElementById("loginButtonAction");
    loginToggleButton &&
    loginToggleButton.addEventListener("click", function (event) {
      event.preventDefault();
      const loginToggle = document.getElementById("login");
      if (loginToggle.style.display === "none") {
        loginToggle.style.display = "block";
      } else {
        loginToggle.style.display = "none";
      }
      });

  const loginButton = document.getElementById("login-submit-button");
  loginButton &&
    loginButton.addEventListener("click", function (event) {
      event.preventDefault();
      const username = document.getElementById("username");
      const password = document.getElementById("password");
      login(username.value, password.value).then((result) => {
        var resultTable = [];
        for(var i in result)
        resultTable.push([i,result[i]]);
        console.log(resultTable);

        if (resultTable[1][1] == "login failed"){
          const postForm = document.getElementById("textEditor");
          postForm.style.display = "none";
          const wrongCred = document.getElementById("wrongCred");
          wrongCred.style.display = "block";
        } else {
          const postForm = document.getElementById("textEditor");
          postForm.style.display = "block";
          const welcomeLabel = document.getElementById("loginStatus");
          welcomeLabel.innerHTML = "Welcome " + resultTable[2][1] + "! ";
          const loginForm = document.getElementById("login");
          loginForm.style.display = "none";
          const loginBtnAct = document.getElementById("loginButtonAction");
          loginBtnAct.style.display = "none";
          const wrongCred = document.getElementById("wrongCred");
          wrongCred.style.display = "none";
          const logoutButton = document.getElementById("logout-submit-button");
          logoutButton.style.display = "block";

        }
        
      });
    });

    const logoutButton = document.getElementById("logout-submit-button");
    logoutButton &&
      logoutButton.addEventListener("click", function (event) {
        logout().then((result) => {
          const postForm = document.getElementById("textEditor");
          postForm.style.display = "none";
          logoutButton.style.display = "none";
          const welcomeLabel = document.getElementById("loginStatus");
          welcomeLabel.innerHTML = "You are not signed in!";
          const loginBtnAct = document.getElementById("loginButtonAction");
          loginBtnAct.style.display = "block";
        });
      });
});
