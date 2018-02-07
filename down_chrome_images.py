#!/usr/bin/env python
"""Download all CHIP chrome-flasher images
Written by Jonathan A. Foster <jon@jfpossibilities.com>
Started February 4th, 2018

This script is provided free to be used however you see fit. There is
absolutely no warranty of any kind.

Requirements:
    This script uses "wget" to pull down files.
"""
import urllib, httplib, json, sys, os



class FlashAPI(object):
    """Simple jig for making API queries against NTC's flash server"""
    host        = 'flash.getchip.com'
    socket_type = httplib.HTTPConnection
    user_agent  = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36'
    accept      = 'application/json, text/plain, */*'



    def __init__(self):
        self.clear()
    def clear(self):
        """Reset all data fields"""
        self.status  = None
        self.reason  = None
        self.headers = None
        self.body    = None
        self.data    = None



    def req(self, uri, meth='GET', body=None):
        """Send request to server"""
        self.clear()
        h = self.socket_type(self.host)
        hdrs = { 'Accept': self.accept,  'User-Agent': self.user_agent }
        h.request(meth, uri, body, hdrs)
        r = h.getresponse()
        self.status  = r.status
        self.reason  = r.reason
        self.headers = r.getheaders()
        self.body    = r.read()
        if r.status == 200:
            self.data    = json.loads(self.body)
        else:
            raise ValueError('%s %s\n%s'
                % (self.status, self.reason, self.body))
        return self



    def urlenc(self, d):
        """URL encode a dictionary of values into an URL query string

        This implements NTC specific URL encoding logic. Hopefully they are
        consistent.
        """
        r = []
        for x in d:
            v = d[x]
            t = type(v)
            x = str(x)
            if t==tuple or t==list:
                x+='[]'
                for y in v: r.append((x, str(y)))
            elif t==bool:
                r.append((x, str(v).lower()))
            else: # everything else we assume can be converted to a string
                r.append((x, str(v)))
        return urllib.urlencode(r)



    def ls(self, device=['C.H.I.P.', 'PocketC.H.I.P.'], legacy=True, current=True, environment='', hideChooseFile=True):
        """Get list of available flash images"""
        u = '/flashImages?'+self.urlenc({
            'device': device,
            'legacy': legacy,
            'current': current,
            'environemnt': environment,
            'hideChooseFile': hideChooseFile,
        })
        self.req(u)
        return self



    def down_em_all(self):
        """Retrieve all available images"""
        self.ls()
        for i in self.data:
            print i['name']
            os.system("wget -c '%s'"
                % i['url'].replace("'", "'\\''"))
        return self



if __name__=='__main__': FlashAPI().down_em_all()
