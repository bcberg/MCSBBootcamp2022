# Module 6

## Background

Many molecules must travel from the cell surface to a pore on the nucleus (called a nuclear pore complex or NPC), either alone or in a relay with other molecules. Examples include [WNT](https://www.google.com/search?q=wnt+pathway&tbm=isch), [YAP/TAZ](https://www.google.com/search?q=yap+taz+pathway&tbm=isch), [Hedgehog](https://www.google.com/search?q=hedgehog+signaling+pathway&tbm=isch).

* We can simulate this in Matlab using the m-file in the `matlab` directory.

* We can simulate this in C using the c file in the `C` directory.

  C has a reputation for being very fast. You can tell by the 100,000s of people who compare themselves to it by saying things like ["Faster than C"](https://www.google.com/search?q=Faster+than+C) or ["As fast as C"](https://www.google.com/search?q=As+fast+as+C).

  To do so, you need a C compiler like `gcc`. At the terminal, run

    ```
    gcc -lm -O3 main.c
    time ./a.out
    ```

* We can also do this using other languages like Julia.

## Julia in a Jupyter notebook on an external server

Julia is a high-level language with cutting-edge on-the-fly compiling, which makes it efficient. 

Colab is a service provided by Google that allows you to run code on their server, through a browser. 

* New: To create a Julia colab notebook, follow the instructions here: [Julia on Colab](https://github.com/Dsantra92/Julia-on-Colab/blob/master/Julia_on_colab.ipynb)

* OLD: To create a Julia colab notebook, follow the instructions here: [Julia Colab Notebook Template](https://github.com/ageron/julia_notebooks). The first time it runs, it will be slow. 