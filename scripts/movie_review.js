let addOrEditMediaForm = document.getElementById("add_or_edit_media_form");

addOrEditMediaForm.addEventListener("submit", addOrEditMediaFormListener);

//document.getElementById("register_form_submit").onclick() = getUserRegistrationFromStuff();

function addOrEditMediaFormListener(e){
    e.preventDefault();


    let title = document.getElementById("title").value;
    let authors = document.getElementById("authors").value;
    let genre = document.getElementById("genre").value;
    let movieOrSeriesSelectedValue = document.querySelector('input[name="is_movie_or_series"]:checked').value;
    let watchStatusSelectedValue = document.querySelector('input[name="watch_status"]:checked').value;
    let starRatingSelectedValue = document.querySelector('input[name="star_rating"]:checked').value;
    let methodOfViewing = document.getElementById("method_of_viewing").value;
    let reviewOrSummary = document.getElementById("review_textbox").value;
    let favQuotes = document.getElementById("fav_qutes").value;

    

    //let mediaDetails =  new MediaDetails(title, authors, genre, movieOrSeriesSelectedValue, watchStatusSelectedValue, starRatingSelectedValue, methodOfViewing, reviewOrSummary, favQuotes);
    let mediaDetails = {
        title,
        authors,
        genre,
        movieOrSeriesSelectedValue,
        watchStatusSelectedValue,
        starRatingSelectedValue,
        methodOfViewing,
        reviewOrSummary,
        favQuotes,
    };
    console.log(mediaDetails);

    return mediaDetails;

}


function MediaDetails(title, authors, genre, isMovieOrSeries, watchStatus, starRating, methodOfViewing, reviewOrSummary, favQuotes){
    this.title = title;
    this.authors = authors;
    this.genre = genre;
    this.isMovieOrSeries = isMovieOrSeries;
    this.watchStatus = watchStatus;
    this.starRating = starRating;
    this.methodOfViewing = methodOfViewing;
    this.reviewOrSummary = reviewOrSummary;
    this.favQuotes = favQuotes;
}



