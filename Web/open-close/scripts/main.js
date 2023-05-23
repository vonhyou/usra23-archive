var urls = []; // Array to hold URLs
var interval = 0; // Interval between opening URLs

// Function to count and display number of URLs
function countURLs() {
  var urlInput = document.getElementById('urlInput').value;
  urls = urlInput.split('\n').filter(url => url.trim() !== ''); // Split URLs from textarea by newline

  var fileInput = document.getElementById('fileInput').files[0];
  if (fileInput) {
    var reader = new FileReader();
    reader.onload = function () {
      // Concatenate URLs from file to existing URLs
      urls = urls.concat(reader.result.split('\n').filter(url => url.trim() !== ''));
      displayURLCount();
    }
    reader.onerror = function () {
      console.error('Failed to read file');
      reader.abort();
    };
    reader.readAsText(fileInput);
  } else {
    displayURLCount();
  }
}

// Function to display number of URLs
function displayURLCount() {
  document.getElementById('urlCount').innerText = 'URL count: ' + urls.length;
  console.log(urls); // Log the URLs after they have been read from file or textarea
}

// Function to generate random interval
function generateInterval() {
  interval = Math.floor(Math.random() * 10) + 1; // Random interval between 1 and 10 seconds
  document.getElementById('interval').innerText = 'Interval: ' + interval + ' seconds';
}

// Function to open URLs
function startURLs() {
  if (urls.length == 0) {
    alert("No URLs provided. Please enter URLs in the text area or upload a file.");
    return;
  }

  let i = 0;
  function openNextURL() {
    if (i < urls.length) {
      // Open the URL in a new tab
      var closeWindow = window.open("https://" + urls[i]);
      setTimeout(function () {
        // Close the tab after the specified interval
        closeWindow.close();
        i++;
        openNextURL();
      }, interval * 1000);
    }
  }
  openNextURL();
}
