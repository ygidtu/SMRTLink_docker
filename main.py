#!/usr/bin/env python3
# -*- coding:utf-8 -*-
u"""
Created at 2019.12.30

This is the entry point of cmd tools of smrtlinks
"""
import os
from sys import argv
from subprocess import check_call, Popen


def main(args=argv[1:]):
    u"""
    Main function to call cmd tools of smrtlinks
    :param args:
    :return:
    """

    root_dir = "/home/smrtanalysis/smrtlink/smrtcmds/bin/"

    if len(args) < 1 or args[0] == "--list" or args[0] == "-l":
        for i in os.listdir(root_dir):
            if os.path.isfile(os.path.join(root_dir, i)):
                print(i)
    elif args[0] == "--version" or args[0] == "-v":
        for i in os.listdir("./"):
            if i.endswith(".run.md5"):
                print(i.replace(".run.md5", ""))
    else:
        exec = os.path.join(root_dir, args[0])

        if not os.path.exists(exec):
            print("{} not exists".format(args[0]))
            print("Please use command as follow")
            print("=" * 80)
            for i in os.listdir(root_dir):
                if os.path.isfile(os.path.join(root_dir, i)):
                    print(i)
        else:
            check_call("{} {}".format(exec, " ".join(args[1:])), shell=True)


if __name__ == '__main__':
    main(args=argv[1:])
