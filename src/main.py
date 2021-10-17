import pygame

from food import *
import concurrent.futures
from concurrent.futures import as_completed


SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600
NUMBER_OF_DOTS = 300


pygame.init()
screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))

dots = []

crashed = False

clock = pygame.time.Clock()
font = pygame.font.SysFont(None, 100)

time_delay = 1000
timer_event = pygame.USEREVENT + 1
pygame.time.set_timer(timer_event, time_delay)

counter = 0
countPoint = 0
text = font.render(str(counter), True, (0, 128, 0))

values = [2,3,4,5]
def square(n):
    #print(n * n)
    return n * n

while not crashed:
    clock.tick(60)

    with concurrent.futures.ThreadPoolExecutor(max_workers=4) as executor:
        results = executor.map(square, values)
    for result in results:
        print(result)

    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            crashed = True

        elif event.type == pygame.MOUSEBUTTONUP:
            if event.button == 1:
                x_cursor = pygame.mouse.get_pos()[0]
                y_cursor = pygame.mouse.get_pos()[1]
                dots.append(Food(x_cursor, y_cursor, screen))

        elif event.type == timer_event:
            for dot in dots:
                text = font.render(str(dot.counter), True, (0, 128, 0))

    screen.fill((255, 255, 255))
    text_rect = text.get_rect(center = screen.get_rect().center)
    screen.blit(text, text_rect)

    countPoint = 0
    for dot in dots:
        countPoint += 1
        dot.fire()
        if dot.destroy:
            dots.remove(dots[countPoint - 1])
        dot.draw()


    pygame.display.flip()