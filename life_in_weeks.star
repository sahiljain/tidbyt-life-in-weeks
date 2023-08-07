"""
    Displays number of weeks that have passed since birth, and number of weeks 
    left until turning ~79. Each dot represents 2 weeks of life.
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
    bi_weeks_alive = math.round(hours_alive / 24 / 14)

    num_full_columns = math.floor(bi_weeks_alive / 32)

    remainder = int(bi_weeks_alive % 32)

    num_future_columns = 64 - num_full_columns - 1
    columns_left = 32 - 1 - remainder

    passed_color = "#ada25f"
    current_color = "#d9f2ff"
    future_color = "#5e035e"

    return render.Root(
        delay = 750,
        child = render.Row(
            children = [
                render.Box(width=num_full_columns, height=32, color=passed_color),
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
                render.Box(width=num_future_columns, height=32, color=future_color),
            ],
        )
    )
