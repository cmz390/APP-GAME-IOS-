from twisted.internet.protocol import Protocol, Factory
from twisted.internet import reactor

#self.factory.clients[24].transport.write("You are client 24!")


class IphoneChat(Protocol):
    def connectionMade(self):
        #self.transport.write("""connected""")
        self.factory.clients.append(self)
            for c in self.factory.clients:
                index = self.factory.clients.index(c)
                    msg ="conpid:"
                        abc =":0:0:0:0:0:0:0:0:0:"
                        efg = str(index)
                        msg = msg + efg + abc
                        c.message(msg)
                print "clients are ", index
    
    def connectionLost(self, reason):
        self.factory.clients.remove(self)
            for c in self.factory.clients:
                index = self.factory.clients.index(c)
                    msg ="conpid:"
                        abc =":0:0:0:0:0:0:0:0:"
                        efg = str(index)
                        msg = msg + efg + abc
                        c.message(msg)
        
        def dataReceived(self, data):
            #print "data is ", data
            #global value
            
            a = data.split(':')
                print "client said: ", a
                if len(a) > 1:
                    command = a[0]
                        tpid = int ((a[1]))
                        tstatus = int ((a[2]))
                        thealty = int ((a[3]))
                        tchoice = int ((a[4]))
                        
                        msg = ""
                        if command == "get":
                            for c in self.factory.clients:
                                index = self.factory.clients.index(c)
                                    msg ="conpid:"
                                        abc =":0:0:0:0:0:0:0:0:"
                                        efg = str(index)
                                        msg = msg + efg + abc
                                        c.message(msg)
                    
                        elif command == "gameover":
                            msg = "gameover:"
                                abc = ":0:0:0:0:0:0:0:0:"
                                    efg = str(tpid)
                                        msg = msg + efg + abc
                        
                        elif command == "set":
                            pid[tpid%3] = tpid
                                status[tpid%3] = tstatus
                                healty[tpid%3] = thealty
                                choice[tpid%3] = tchoice
                                s0 = "content"
                                s1 = str(status[0])
                                s2 = str(healty[0])
                                s3 = str(choice[0])
                                s4 = str(status[1])
                                s5 = str(healty[1])
                                s6 = str(choice[1])
                                s7 = str(status[2])
                                s8 = str(healty[2])
                                s9 = str(choice[2])
                                msg = s0 + ":"+s1 +":"+ s2 +":"+ s3 +":"+ s4 +":"+ s5 +":"+ s6 +":"+ s7 +":"+ s8 +":"+ s9+ ":"
                        
                        print msg
                        
                        for c in self.factory.clients:
                            c.message(msg)
                        
                        def message(self, message):
                            self.transport.write(message + '\n')


factory = Factory()
pid = [0,0,0]
status = [0,0,0]
healty = [0,0,0]
choice = [0,0,0]
factory.protocol = IphoneChat
factory.clients = []
reactor.listenTCP(80, factory)
print "Iphone Chat server started"
reactor.run()
