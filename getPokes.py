import bs4
import urllib.request
import requests
import os.path
import sys
import subprocess


def main():
    # Get path of folder where images should be downloaded and parse that path to make sure it's valid.
    download_folder = input("Enter the directory where to save the pokemon images:\t")
    download_folder = ''.join(download_folder.split())

    if os.path.isdir(download_folder):
        print("Folder already exists. Not needed to create")
    else:
        try:
            os.mkdir(download_folder)
        except OSError:
            sys.exit("Creation of the directory %s failed" % download_folder)
        else:
            print("Successfully created the directory %s " % download_folder)

    if not download_folder.endswith('/'):
        download_folder = download_folder + "/"

    # Get html page where the images are stored.
    url = 'https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_National_Pok%C3%A9dex_number'
    hdr = {
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
        'Accept-Charset': 'ISO-8859-1,utf-8;q=0.7,*;q=0.3',
        'Accept-Encoding': 'none',
        'Accept-Language': 'en-US,en;q=0.8',
        'Connection': 'keep-alive'}

    request = urllib.request.Request(url, headers=hdr)
    try:
        page = urllib.request.urlopen(request)
        soup = bs4.BeautifulSoup(page, "html.parser")
        images = soup.find_all('img')

        # Check each image existent in the html page
        for img in images:
            # Parse valid images only.
            if len(img['alt']) < 20:
                poke_name = img['alt'] + ".png"
                poke_image_link = "https:" + img['src']

                # If the images don't exist in the input folder by the user, download them.
                if not os.path.isfile(download_folder + poke_name):
                    print(poke_name)
                    r = requests.get(poke_image_link, allow_redirects=True)
                    open(download_folder + poke_name, 'wb').write(r.content)

        # After the images where downloaded, cuts the useless empty areas around them.
        subprocess.call("./tune_images.sh " + download_folder + "*.png", shell=True)

    except urllib.error.HTTPError as err:
        sys.exit(err)


# Start program
if __name__ == "__main__":
    main()
