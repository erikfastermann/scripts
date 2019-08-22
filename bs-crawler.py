'''bs.to crawler

DESCRIPTION:
The "Burning Series" crawler automatically crawls the episode links from one provider
(e.g.: OpenLoadHD) for a specified season. You can copy these links into JDownloader 2
to download the episodes. The advantage of using this tool over a JDownloader rule,
is that you don't have to solve the other providers Captchas, only for the specified provider.

USAGE WITH JDOWNLOADER2:
Copy the links into JDownloader 2 by clicking "LinkGrabber" and "Add New Links".
If they aren't already visible, paste them into the empty field and click continue.
TIP: Only use the "Normal Link Analyse" Feature!
Than JDownloader should start analyzing these links and open your browser for you
to solve the Captchas and add all episodes to the LinkGrabber list. This only works
with the JDownloader Browser Extension installed, so follow the link and download
it for your browser. If JDownloader did't find all episodes after you solved every Captcha,
try again, only with the episode links that didn't work.
If JDowloader is finished with collecting the links, click "Start all Downloads".
'''

import requests
from bs4 import BeautifulSoup

def getProviderEps(bsUrl, provider):
    sourceCode = requests.get(bsUrl)
    plainText = sourceCode.text
    soup = BeautifulSoup(plainText, 'html.parser')

    bsAll = []
    for bsEp in range(1, 100):
        data = soup.findAll('div',attrs={'class': 'epiInfo {}'.format(bsEp)})
        for div in data:
            links = div.findAll('a')
            for a in links:
                urlBsAll = "http://bs.to/" + a['href']
                bsAll.append(urlBsAll)

    providerLinks = [s for s in bsAll if provider in s]
    return(providerLinks)

if __name__ == '__main__':
    provider = '/OpenLoadHD' #change provider here

    print('Burning Series (https://bs.to) season crawler')
    print('Additional program for downloading bs.to seasons with JDownloader 2')
    print('WARNING: This Program is for demonstration purposes only!')
    print()
    print('Current provider: {}'.format(provider))
    print('Change the provider to another streaming service by editing the provider variable, e.g.: to /Vivo')
    print()

    print('Copy the link from an episode of the season.')
    print('IMPORTANT: Do NOT only copy the link of the season (e.g.: https://bs.to/serie/Mr-Robot/1/)!')
    bsUrl = str(input('URL (e.g.: https://bs.to/serie/Mr-Robot/1/1-Eps1-0-hellofriend-mov): '))
    bsUrl = bsUrl.strip()
    print()
    print('URL: {}'.format(bsUrl))

    providerLinks = getProviderEps(bsUrl, provider)

    providerEps = str(len(providerLinks))
    print('Found {} {} Episode(s):'.format(providerEps, provider))
    print(*providerLinks, sep = "\n")

    print()
    input('Press <ENTER> to exit')
