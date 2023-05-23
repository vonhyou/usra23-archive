var urls = [];
var interval = 0;

function countURLs() {
  var urlInput = document.getElementById('urlInput').value;
  urls = urlInput.split('\n');

  var fileInput = document.getElementById('fileInput').files[0];
  if (fileInput) {
    var reader = new FileReader();
    reader.onload = function () {
      urls = urls.concat(reader.result.split('\n'));
      displayURLCount();
    }
    reader.readAsText(fileInput);
  } else {
    displayURLCount();
  }

  console.log(urls)
}

function displayURLCount() {
  document.getElementById('urlCount').innerText = 'URL count: ' + urls.length;
}

function generateInterval() {
  interval = Math.floor(Math.random() * 10) + 1;
  document.getElementById('interval').innerText = 'Interval: ' + interval + ' seconds';
}

function startURLs() {
  let i = 0;
  function openNextURL() {
    if (i < urls.length) {
      var closeWindow = window.open("https://" + urls[i]);
      setTimeout(function () {
        closeWindow.close();
        i++;
        openNextURL();
      }, interval * 1000);
    }
  }
  openNextURL();
}