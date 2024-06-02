<%--
  Created by IntelliJ IDEA.
  User: Test
  Date: 02.06.2024
  Time: 13:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Songs table</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <style>
        .pricing-header {
            max-width: 700px;
        }
        .table-responsive{
            margin: 0 auto;
            max-width: 960px;
        }
        .form_songs{
            margin: 0 auto;
            max-width: 960px;
        }
    </style>
</head>
<body>
    <script type="module">
        let request = new XMLHttpRequest();
        request.open("GET", "songs.json");

        request.responseType = "json";
        request.send();

        request.onload = function() {
            let response = request.response;
            fillTable(response);
        }
        function fillTable(response) {
            let tbody = document.querySelector("tbody");
            //let songsArray = response["songs"];
            response.forEach(object => {
                let newSong = document.createElement("tr");
                let name = object["songName"];
                let author = object["author"];
                let album = object["album"];
                let length = object["length"];
                let year = object["year"];
                let id = object["id"];
                newSong.innerHTML =
                    '<th scope="row" class="text-start">' + name +
                    '</th><td class="text-body-secondary">' + author +
                    '</td><td class="text-body-secondary">' + album +
                    '</td><td class="text-body-secondary">' + length +
                    '</td><td class="text-body-secondary">' + year +
                    '</td><td class="text-body-secondary">' + id + '</td>';

                tbody.appendChild(newSong);
            });
        }

        function deleteElement(id){
            let answer = confirm("Are you sure you want to delete this song?");

            if(answer){
                let deleteRequest = new XMLHttpRequest();
                deleteRequest.open()
            }
        }
    </script>

    <div class="container py-3">
        <header>
            <div class="d-flex flex-column flex-md-row align-items-center pb-3 mb-4 border-bottom"><!--border-bottom-->
                <a href="${pageContext.request.contextPath}/prices" class="d-flex align-items-center link-body-emphasis text-decoration-none">
                    <svg xmlns="http://www.w3.org/2000/svg" width="40" height="32" class="me-2" viewBox="0 0 118 94" role="img">
                        <title>The songbook</title>
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M24.509 0c-6.733 0-11.715 5.893-11.492 12.284.214 6.14-.064 14.092-2.066 20.577C8.943 39.365 5.547 43.485 0 44.014v5.972c5.547.529 8.943 4.649 10.951 11.153 2.002 6.485 2.28 14.437 2.066 20.577C12.794 88.106 17.776 94 24.51 94H93.5c6.733 0 11.714-5.893 11.491-12.284-.214-6.14.064-14.092 2.066-20.577 2.009-6.504 5.396-10.624 10.943-11.153v-5.972c-5.547-.529-8.934-4.649-10.943-11.153-2.002-6.484-2.28-14.437-2.066-20.577C105.214 5.894 100.233 0 93.5 0H24.508zM80 57.863C80 66.663 73.436 72 62.543 72H44a2 2 0 01-2-2V24a2 2 0 012-2h18.437c9.083 0 15.044 4.92 15.044 12.474 0 5.302-4.01 10.049-9.119 10.88v.277C75.317 46.394 80 51.21 80 57.863zM60.521 28.34H49.948v14.934h8.905c6.884 0 10.68-2.772 10.68-7.727 0-4.643-3.264-7.207-9.012-7.207zM49.948 49.2v16.458H60.91c7.167 0 10.964-2.876 10.964-8.281 0-5.406-3.903-8.178-11.425-8.178H49.948z" fill="currentColor"></path>
                    </svg>
                    <span class="fs-4">The songbook</span>
                </a>
                <nav class="d-inline-flex mt-2 mt-md-0 ms-md-auto">
                    <a class="me-3 py-2 link-body-emphasis text-decoration-none" href="">About us</a>
                    <a class="me-3 py-2 link-body-emphasis text-decoration-none" href="">Our contacts</a>
                    <a class="me-3 py-2 link-body-emphasis text-decoration-none" href="">Other services</a>
                    <a class="py-2 link-body-emphasis text-decoration-none" href="">Feedback</a>
                </nav>
            </div>

            <div class="pricing-header p-3 pb-md-4 mx-auto text-center">
                <h1 class="display-4 fw-normal text-body-emphasis">Songs table</h1>
                <p class="fs-5 text-body-secondary">In this page you can see all songs that are contained in the local database</p>
            </div>
        </header>
        <main>
            <h2 class="display-6 text-center mb-4">Add new song</h2>

            <form class="form_songs" method="post">
                <div class="mb-3">
                    <label for="song_name" class="form-label">Song name</label>
                    <input type="text" class="form-control" id="song_name" name="song_name">
                </div>
                <div class="mb-3">
                    <label for="author" class="form-label">Author</label>
                    <input type="text" class="form-control" id="author" name="author">
                </div>
                <div class="mb-3">
                    <label for="album" class="form-label">Album</label>
                    <input type="text" class="form-control" id="album" name="album">
                </div>
                <div class="mb-3">
                    <label for="length" class="form-label">Length</label>
                    <input type="text" class="form-control" id="length" name="length">
                </div>
                <div class="mb-3">
                    <label for="year" class="form-label">Year</label>
                    <input type="text" class="form-control" id="year" name="year">
                </div>

                <button id = "myButton" class="btn btn-primary btn-lg" type="submit" onclick="">Add song to the songbook</button>

            </form>

            <h2 class="display-6 text-center mb-4">Delete song</h2>

            <form class="form_songs" method="post">
                <div class="mb-3">
                    <label for="song_name" class="form-label">Song Id</label>
                    <input type="text" class="form-control" id="song_id" name="song_id">
                </div>

                <button id = "myDellButton" class="btn btn-primary btn-lg" type="submit" onclick="">Delete song from the songbook</button>

            </form>

            <h2 class="display-6 text-center mb-4">Update song</h2>

            <form class="form_songs" method="post">
                <div class="mb-3">
                    <label for="song_name" class="form-label">Song Id</label>
                    <input type="text" class="form-control" id="id" name="id">
                </div>
                <div class="mb-3">
                    <label for="song_name" class="form-label">Song name</label>
                    <input type="text" class="form-control" id="new_song_name" name="new_song_name">
                </div>
                <div class="mb-3">
                    <label for="author" class="form-label">Author</label>
                    <input type="text" class="form-control" id="new_author" name="new_author">
                </div>
                <div class="mb-3">
                    <label for="album" class="form-label">Album</label>
                    <input type="text" class="form-control" id="new_album" name="new_album">
                </div>
                <div class="mb-3">
                    <label for="length" class="form-label">Length</label>
                    <input type="text" class="form-control" id="new_length" name="new_length">
                </div>
                <div class="mb-3">
                    <label for="year" class="form-label">Year</label>
                    <input type="text" class="form-control" id="new_year" name="new_year">
                </div>

                <button id = "myUpdateButton" class="btn btn-primary btn-lg" type="submit" onclick="">Update song in the songbook</button>

            </form>

            <p>
                <h2 class="display-6 text-center mb-4">All current songs from local storage</h2>
            </p>

            <div class="table-responsive">
                <table class="table text-center">
                    <thead>
                    <tr>
                        <th style="width: 34%;">Name</th>
                        <th style="width: 34%;">Author</th>
                        <th style="width: 22%;">Album</th>
                        <th style="width: 22%;">Length</th>
                        <th style="width: 22%;">Year</th>
                        <th style="width: 22%;">Id</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <th scope="row" class="text-start">Interchanger</th>
                        <td class="text-body-secondary">The Anix</td>
                        <td class="text-body-secondary">Shadow_Movement</td>
                        <td class="text-body-secondary">4:53</td>
                        <td class="text-body-secondary">2018</td>
                        <td class="text-body-secondary">0</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </main>

        <footer class="pt-4 my-md-5 pt-md-5 border-top">
            <div class="row">
                <div class="col-12 col-md">
                    <img class="mb-2" src="${pageContext.request.contextPath}/assets/vpn.svg" alt="" width="24" height="19">
                    <small class="d-block mb-3 text-body-secondary">&copy; 2017–2024</small>
                </div>
                <div class="col-6 col-md">
                    <h5>Features</h5>
                    <ul class="list-unstyled text-small">
                        <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Cool stuff</a></li>
                        <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Random feature</a></li>
                        <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Team feature</a></li>
                        <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Stuff for developers</a></li>
                        <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Another one</a></li>
                        <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Last time</a></li>
                    </ul>
                </div>
                <div class="col-6 col-md">
                    <h5>Resources</h5>
                    <ul class="list-unstyled text-small">
                        <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Resource</a></li>
                        <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Resource name</a></li>
                        <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Another resource</a></li>
                        <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Final resource</a></li>
                    </ul>
                </div>
                <div class="col-6 col-md">
                    <h5>About</h5>
                    <ul class="list-unstyled text-small">
                        <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Team</a></li>
                        <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Locations</a></li>
                        <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Privacy</a></li>
                        <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Terms</a></li>
                    </ul>
                </div>
            </div>
        </footer>
    </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>
</html>
