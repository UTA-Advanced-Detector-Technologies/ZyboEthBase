# interfacing dependcies
from eth_interface import (eth_interface, EthBadAddr, REG, DEFAULT_PACKET_SIZE, ZYBO_FRQ)
import os
import sys
import time

# PyQt GUI things
from PyQt5 import QtCore
from PyQt5.QtWidgets import (QWidget, QPushButton, QCheckBox, QComboBox, QSpinBox, QLabel,
                             QDoubleSpinBox, QProgressBar, QTabWidget, QVBoxLayout, QHBoxLayout, QGridLayout, QStatusBar,
                             QDialog, QDialogButtonBox, QLCDNumber, QFileDialog)
from PyQt5.QtCore import QProcess, QTimer, pyqtSignal
from PyQt5.QtGui import QIcon
from PyQt5.QtWidgets import QApplication, QMainWindow, QAction


class GUI(QMainWindow):

    close_udp = pyqtSignal()

    def __init__(self):
        super(QMainWindow, self).__init__()

        # IO interfaces
        self.eth = eth_interface()
        self.close_udp.connect(self.eth.finish) # closes udp worker thread
        self.version = self.eth.version

        # window setup
        self.setWindowTitle('Ethernet Control')

        # passive triggering
        self._clock = QTimer()
        self._clock.timeout.connect(self.trigger)
        self._lastTrig = -1

        # initialize the sub menus
        self._make_menuBar()

        # create the layouts that are needed for making the GUI pretty
        self.tabW = QTabWidget()
        self.tabW.addTab(self._makeEthlayout(), "ETH")
        self.setCentralWidget(self.tabW)

        # show the main window
        self.show()

    def _makeEthlayout(self):
        """
        Wrapper function to store all of the Eth widgets into a single layout,
        and finally add it to the main window's QStackLayout
        """

        self._qdbPage = QWidget()
        layout = QGridLayout()

        btn_init = QPushButton()
        btn_init.setText('read ID')
        btn_init.clicked.connect(self.readID)
        layout.addWidget(btn_init, 0, 0)

        btn = QPushButton()
        btn.setText('trigger')
        btn.clicked.connect(lambda: self.trigger(hard=True))
        layout.addWidget(btn, 0, 1)

        btn_gtimeout = QPushButton()
        btn_gtimeout.setText('read reg')
        btn_gtimeout.clicked.connect(self.readReg)
        layout.addWidget(btn_gtimeout, 0, 2)

        btn_writeReg = QPushButton()
        btn_writeReg.setText('write reg')
        btn_writeReg.clicked.connect(self.writeReg)
        layout.addWidget(btn_writeReg, 1, 0)

        self.s_addr = QSpinBox()
        self.s_addr.setRange(0, 32)
        self.s_addr.setValue(0)
        self._laddr = QLabel("addr")
        layout.addWidget(self._laddr, 1, 1)
        layout.addWidget(self.s_addr, 2, 1)

        self.s_addrVal = QSpinBox()
        self.s_addrVal.setRange(0, 32)
        self.s_addrVal.setValue(0)
        self._lval = QLabel("val")
        layout.addWidget(self._lval, 1, 2)
        layout.addWidget(self.s_addrVal, 2, 2)

        self._qdbPage.setLayout(layout)
        return self._qdbPage

    ############################
    ## Zybo specific Commands ##
    ############################
    def readID(self):
        """
        Main function to send a trigger to update the two register addresses to read the eeprom ID
        """
        self.trigger(hard=False)
        time.sleep(0.100)
        lowVal = self.readReg(2)
        data = 0xffff_ffff & lowVal
        data = data >> 4
        highVal = self.readReg(3)
        highVal = highVal & 0xff
        highVal = highVal << 28
        data += highVal
        print(f"reg read val: {data:08x}")

    def readReg(self):
        """
        read a specific asic reg
        """
        addr = self.s_addr.value()
        readVal = self.eth.regRead(addr)
        print(f"read addr reg: 0x{addr:06x}")
        print(f"reg read val: {readVal:08x}")
        return readVal

    def writeReg(self):
        """
        write a specific asic reg
        """
        addr = self.s_addr.value()
        val = self.s_addrVal.value()
        print(f"writing addr reg: 0x{addr:06x}")
        print(f"writing val: 0x{val:04x}")
        self.eth.regWrite(addr, val)

    def trigger(self, hard=True):
        """
        Send a basic trigger packet to the board.

        This interrogation will be sent to all ASICs in the array, and memory
        will be recorded into the BRAM within QpixDaqCtrl.vhd.
        """
        if hard:
            print("sending trig")
        addr = REG.TRIG
        self.eth.regWrite(addr, 1)


    def getDMARegisters(self):
        """
        Print the DMA register status, connected to a button
        """
        print("printing DMA Registers:")
        self.eth.PrintDMA()


    def resetDMA(self):
        """
        reset DMA by pinging the correct ctrl register
        """
        print("reseting the DMA!")
        self.eth._resetDMA()


    ###########################
    ## GUI specific Commands ##
    ###########################

    def _make_menuBar(self):
        menubar = self.menuBar()
        menubar.setNativeMenuBar(False)

        # exit action
        exitAct = QAction(QIcon(), '&Exit', self)
        exitAct.setShortcut('Ctrl+Q')
        exitAct.setStatusTip('Exit application')
        exitAct.triggered.connect(self.close)

        # create a way to save the data collected
        saveAct = QAction(QIcon(), '&Save', self)
        saveAct.setShortcut('Ctrl+S')
        saveAct.setStatusTip('Save Data')
        saveAct.triggered.connect(self.SaveAs)

        # add the actions to the menuBar
        fileMenu = menubar.addMenu('File')
        fileMenu.addAction(exitAct)
        fileMenu.addAction(saveAct)

    def SaveAs(self):
        """
        file save
        """
        pass

    def reject(self):
        pass


if __name__ == "__main__":

    app = QApplication(sys.argv)
    window = GUI()
    app.exec_()
