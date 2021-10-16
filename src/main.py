import pygame


pygame.init()


display_width = 800
display_height = 600

gameDisplay = pygame.display.set_mode((display_width,display_height))
pygame.display.set_caption('A bit Racey')

black = (0, 0, 0)
white = (255, 255, 255)

clock = pygame.time.Clock()
crashed = False
carImg = pygame.image.load('bird.png')

test = [pygame.draw.circle(gameDisplay,black,(20,10),20),
        pygame.draw.circle(gameDisplay,black,(30,10),20),
        pygame.draw.circle(gameDisplay,black,(60,10),20)]

def car(x,y):
    global test



x =  (display_width * 0.45)
y = (display_height * 0.8)

while not crashed:

    gameDisplay.fill(white)

    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            crashed = True
        if event.type == pygame.MOUSEBUTTONDOWN:
            if event.button == 1:

                x_cursor = pygame.mouse.get_pos()[0]
                y_cursor = pygame.mouse.get_pos()[1]
                print(x_cursor, y_cursor)
                test.append(pygame.draw.circle(gameDisplay,black,(x_cursor,y_cursor),20))



    car(x,y)


    pygame.display.update()
    clock.tick(60)

pygame.quit()
quit()