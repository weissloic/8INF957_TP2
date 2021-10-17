import pygame
import random as rd


class Food():
    SIZE = 5
    def __init__(self, x, y, screen):
        self.x = x
        self.last = pygame.time.get_ticks()
        self.cooldown = 10000
        self.screen = screen
        self.y = y
        self.color = random_color()
        self.state = True
        self.counter = 10
        self.destroy = False



    def draw(self):
        pygame.draw.circle(self.screen, self.color, (self.x, self.y), Food.SIZE)

    def fire(self):
        # fire gun, only if cooldown has been 0.3 seconds since last
        now = pygame.time.get_ticks()
        print("now", now)
        print("last", self.last)
        if now - self.last >= self.cooldown:
            self.destroy = True
            print("Ready to destroy")
            self.last = now


    def test(self):

        print(self.counter)


def random_color():
    r = rd.randint(0, 255)
    g = rd.randint(0, 255)
    b = rd.randint(0, 255)
    return (r, g, b)