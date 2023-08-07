"""
    Displays number of months that have passed since birth, and number of months 
    left until turning ~85. Each dot represents 2 weeks of life.
"""
load("render.star", "render")
load("time.star", "time")
load("math.star", "math")


def main():
    # Birthday is Feb 6 1995
    birth_time = time.from_timestamp(792108000)

    now = time.now()

    diff = now - birth_time
    hours_alive = diff.hours
    days_alive = hours_alive / 24
    months_alive = math.round(days_alive / 365 * 12)

    width = 64
    height = 16

    num_full_columns = math.floor(months_alive / height)

    remainder = int(months_alive % height)

    num_future_columns = width - num_full_columns - 1
    columns_left = height - 1 - remainder

    passed_color = "#ada25f"
    current_color = "#d9f2ff"
    future_color = "#5e035e"

    return render.Root(
        delay = 750,
        child = render.Column(
            # expanded = True,
            main_align = "space_between",
            cross_align = "center",
            children = [
                render.Box(width = 63, height = 2),
                render.Text(str(int(months_alive)) + " months down", font="CG-pixel-3x5-mono"),
                render.Box(width = 63, height = 2),
                render.Text(str(int(85 * 12 - months_alive)) + " to go!", font="CG-pixel-3x5-mono"),
                render.Box(width = 63, height = 2),
                render.Row(
                    children = [
                        render.Box(width=num_full_columns, height=height, color=passed_color),
                        render.Column(
                            children = [
                                render.Box(width=1, height=remainder, color=passed_color),
                                render.Animation(
                                    children = [
                                        render.Box(width=1, height=1, color=current_color),
                                        render.Box(width=1, height=1, color="#000"),
                                    ]
                                ),
                                render.Box(width=1, height=columns_left, color=future_color)
                            ]
                        ),
                        render.Box(width=num_future_columns, height=height, color=future_color),
                    ],
                )
            ]
        )
    )
